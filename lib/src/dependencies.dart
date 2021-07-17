import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/auth/domain/usescases.dart';
import 'package:heart_rate/modules/home/usecases/usecases.dart';

List<RepositoryProvider> buildRepositories() {
  return [
    // RepositoryProvider<CreateClientUseCase>(create: (_)=> CreateClientUseCase()),
    // RepositoryProvider<AuthStatusUseCase>(create: (_)=> AuthStatusUseCase()),
    // RepositoryProvider<ForgotPasswordUseCase>(create: (_)=> ForgotPasswordUseCase()),
    // RepositoryProvider<MenuUseCase>(create: (_)=> MenuUseCase()),
    // RepositoryProvider<ProductUseCase>(create: (_)=> ProductUseCase()),
    // RepositoryProvider<CartUseCase>(create: (_)=> CartUseCase()),
    // RepositoryProvider<ProductListFilterUseCase>(create: (_)=> ProductListFilterUseCase()),

    RepositoryProvider<LoginUseCase>(
        create: (context) => LoginUseCase(
            // context.read(),
            )),

    RepositoryProvider<HomeUsecase>(create: (context) => HomeUsecase()),
  ];
}
