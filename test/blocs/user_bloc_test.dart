import 'package:bloc_test/bloc_test.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/blocs/user_bloc.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/blocs/user_event.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/blocs/user_state.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/models/address.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/models/user.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  setUpAll(() {
    // Register a fallback value for User so mocktail can use `any()` for User
    registerFallbackValue(User(
      firstName: 'fallback',
      lastName: 'fallback',
      birthDate: DateTime(2000, 1, 1),
    ));
  });

  group('UserBloc', () {
    late UserRepository repository;

    setUp(() {
      repository = MockUserRepository();
      // Ensure loadUser returns a Future (null) by default to avoid constructor errors
      when(() => repository.loadUser()).thenAnswer((_) async => null);
    });

    test('initial state is UserInitial', () {
      final bloc = UserBloc(repository: repository);
      expect(bloc.state, isA<UserInitial>());
    });

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when CreateUser is added',
      build: () {
        when(() => repository.saveUser(any())).thenAnswer((_) async {});
        return UserBloc(repository: repository);
      },
      act: (bloc) => bloc.add(CreateUser(
        firstName: 'Juan',
        lastName: 'Perez',
        birthDate: DateTime(1990, 1, 1),
      )),
      expect: () => [isA<UserLoading>(), isA<UserLoaded>()],
      verify: (_) {
        verify(() => repository.saveUser(any())).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'adds address to existing user',
      build: () {
        when(() => repository.saveUser(any())).thenAnswer((_) async {});
        return UserBloc(repository: repository);
      },
      seed: () => UserLoaded(User(
        firstName: 'Ana',
        lastName: 'Lopez',
        birthDate: DateTime(1992, 5, 10),
      )),
      act: (bloc) => bloc.add(AddAddress(
        address: Address(
            country: 'Colombia',
            department: 'Cundinamarca',
            municipality: 'Bogotá'),
      )),
      expect: () => [isA<UserLoading>(), isA<UserLoaded>()],
      verify: (_) {
        verify(() => repository.saveUser(any())).called(1);
      },
    );
  });
}
