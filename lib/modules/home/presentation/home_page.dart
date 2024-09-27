import 'dart:async';

import 'package:flutter/material.dart';
import '../../../core/core.dart';
import '../../../shared/analytics/analytics.dart';
import '../../../shared/widgets/widgets.dart';
import '../domain/domain.dart';
import 'home_state.dart';
import 'home_viewmodel.dart';
import 'views/details_hero_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePage<HomePage, HomeViewmodel> {
  final AnalyticsService analyticsUseCase = AnalyticsServiceImpl();
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    analyticsUseCase
        .sendAnalyticsEvent('screen_view', {"id": '12345', 'screen': 'home'});
    viewmodel.fetchCharacters();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _searchController = TextEditingController();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        viewmodel.loadMoreCharacters();
      }
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      viewmodel.fetchCharacters(name: _searchController.text);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const AppBarMarvel(
        useBackButton: false,
      ),
      body: ValueListenableBuilder<HomeStatus>(
        valueListenable: viewmodel.state.status,
        builder: (context, state, _) {
          if (state == HomeStatus.loading &&
              viewmodel.state.characters.value.isEmpty) {
            return const Center(child: LoadingIndicator());
          }
          if (state == HomeStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('An error occurred'),
                  ElevatedButton(
                    onPressed: viewmodel.fetchCharacters,
                    child: const Text('Try again'),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFeaturedCharactersSection(width),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: _buildCharacterListSection(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedCharactersSection(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'FEATURED CHARACTERS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: (width - 16) / 2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewmodel.state.characters.value.length,
            itemBuilder: (context, index) {
              final character = viewmodel.state.characters.value[index];
              return SizedBox(
                  width: (width - 16) / 2,
                  child: _buildCharacterCard(character));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCharacterListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MARVEL CHARACTERS LIST',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                    hintText: 'Search characters',
                    hintStyle: const TextStyle(
                      color: Color(0xff484848),
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      height: 1.25,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        _searchController.clear();
                        viewmodel.fetchCharacters();
                      },
                      child: const Icon(
                        Icons.clear,
                        size: 15,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 15,
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: const EdgeInsets.only(
                      top: 16.0,
                    )),
              )
            ],
          ),
        ),
        ValueListenableBuilder<List<Character>>(
          valueListenable: viewmodel.state.characters,
          builder: (context, characters, _) {
            if (viewmodel.state.status.value == HomeStatus.loading) {
              return const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Center(
                  child: LoadingIndicator(),
                ),
              );
            }
            return Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsHeroPage(
                                character: character,
                              ),
                            ),
                          );
                        },
                        child: _buildCharacterCard(character));
                  },
                ),
                ValueListenableBuilder<HomeStatus>(
                    valueListenable: viewmodel.state.status,
                    builder: (context, status, _) {
                      return status == HomeStatus.loadingMore
                          ? const Center(child: LoadingIndicator())
                          : const SizedBox.shrink();
                    }),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCharacterCard(Character character) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                character.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100 * 0.60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.62),
                      Colors.black.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Text(
                character.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
