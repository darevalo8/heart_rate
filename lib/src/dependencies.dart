import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_rate/modules/auth/domain/usescases.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_usecase.dart';
import 'package:heart_rate/modules/home/usecases/usecases.dart';
import 'package:heart_rate/modules/user/usecases/usecases.dart';

List<RepositoryProvider> buildRepositories() {
  return [
    // RepositoryProvider<CreateClientUseCase>(create: (_)=> CreateClientUseCase()),
    // RepositoryProvider<AuthStatusUseCase>(create: (_)=> AuthStatusUseCase()),
    // RepositoryProvider<ForgotPasswordUseCase>(create: (_)=> ForgotPasswordUseCase()),
    // RepositoryProvider<MenuUseCase>(create: (_)=> MenuUseCase()),
    // RepositoryProvider<ProductUseCase>(create: (_)=> ProductUseCase()),
    // RepositoryProvider<CartUseCase>(create: (_)=> CartUseCase()),
    // RepositoryProvider<ProductListFilterUseCase>(create: (_)=> ProductListFilterUseCase()),

    RepositoryProvider<AnomalyUseCase>(create: (_) => AnomalyUseCase()),
    RepositoryProvider<HomeUsecase>(create: (_) => HomeUsecase()),
    RepositoryProvider<UserUsecase>(create: (_) => UserUsecase()),
    RepositoryProvider<LoginUseCase>(
        create: (_) => LoginUseCase(
            // context.read(),
            )),

    
  ];
}
