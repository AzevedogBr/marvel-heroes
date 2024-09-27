import '../../modules/home/data/data.dart';
import '../../modules/home/domain/domain.dart';
import '../../modules/home/presentation/presentation.dart';
import '../infra/http_client.dart';
import 'injector.dart';

void setupInjector() {
  final injector = Injector();

  injector.register<HttpClient>(HttpClient(
    publicKey: '8f492d03106b7ad8addf228e4eda7d6c',
    privateKey: 'f3214332330066084bb900a7f4333700bb7feba2',
  ));
  injector.register<CharacterRemoteDataSource>(
      CharacterRemoteDataSourceImpl(injector.get<HttpClient>()));
  injector.register<CharacterRepository>(
      CharacterRepositoryImpl(injector.get<CharacterRemoteDataSource>()));
  injector.register<GetCharactersUsecase>(
      GetCharactersUsecase(injector.get<CharacterRepository>()));
  injector.register<HomeViewmodel>(
      HomeViewmodel(injector.get<GetCharactersUsecase>()));
}
