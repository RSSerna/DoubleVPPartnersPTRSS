import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/core/core.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/models/user_model.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/entities/address_entity.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/entities/user_entity.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/usecases/create_save_user_use_case.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/usecases/load_user_use_case.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/presentation/bloc/user_bloc.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/presentation/bloc/user_event.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/presentation/bloc/user_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoadUserUseCase extends Mock implements LoadUserUseCase {}

class MockCreateSaveUserUseCase extends Mock implements CreateSaveUserUseCase {}

class FakeUserModel extends Fake implements UserModel {}

class FakeStorageFailure extends Fake implements StorageFailure {
  @override
  String get message => 'Test failure message';
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUserModel());
    registerFallbackValue(NoParams());
    registerFallbackValue(FakeStorageFailure());
  });

  late UserBloc bloc;
  late MockLoadUserUseCase mockLoadUserUseCase;
  late MockCreateSaveUserUseCase mockCreateSaveUserUseCase;

  setUp(() {
    mockLoadUserUseCase = MockLoadUserUseCase();
    mockCreateSaveUserUseCase = MockCreateSaveUserUseCase();

    // Setup default response for loadUserUseCase
    when(() => mockLoadUserUseCase(any())).thenAnswer(
        (_) async => Left(StorageFailure(message: 'No user found')));

    bloc = UserBloc(
      loadUserUseCase: mockLoadUserUseCase,
      createSaveUserUseCase: mockCreateSaveUserUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  final testDate = DateTime(2000, 1, 1);
  final testUser = UserEntity(
    firstName: 'John',
    lastName: 'Doe',
    birthDate: testDate,
  );

  final testAddress = AddressEntity(
    country: 'Test Country',
    department: 'Test Department',
    municipality: 'Test Municipality',
  );

  test('initial state should be UserInitial', () {
    expect(bloc.state, isA<UserInitial>());
  });

  group('CreateUserEvent', () {
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when user creation is successful',
      build: () {
        when(() => mockLoadUserUseCase(any())).thenAnswer(
            (_) async => Left(StorageFailure(message: 'No user found')));
        when(() => mockCreateSaveUserUseCase(any()))
            .thenAnswer((_) async => Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateUserEvent(
        firstName: testUser.firstName,
        lastName: testUser.lastName,
        birthDate: testUser.birthDate,
      )),
      expect: () => [
        isA<UserLoading>(),
        isA<UserLoaded>(),
      ],
      verify: (_) {
        verify(() => mockCreateSaveUserUseCase(any())).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when user creation fails',
      build: () {
        when(() => mockCreateSaveUserUseCase(any())).thenAnswer(
            (_) async => Left(StorageFailure(message: 'Failed to save user')));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateUserEvent(
        firstName: testUser.firstName,
        lastName: testUser.lastName,
        birthDate: testUser.birthDate,
      )),
      expect: () => [
        isA<UserLoading>(),
        isA<UserError>(),
      ],
      verify: (_) {
        verify(() => mockCreateSaveUserUseCase(any())).called(1);
      },
    );
  });

  group('AddAddressEvent', () {
    final userWithoutAddress = testUser;
    final userWithAddress = testUser.copyWith(addresses: [testAddress]);

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when adding address is successful',
      build: () {
        when(() => mockLoadUserUseCase(any()))
            .thenAnswer((_) async => Right(testUser));
        when(() => mockCreateSaveUserUseCase(any()))
            .thenAnswer((_) async => Right(userWithAddress));
        final newBloc = UserBloc(
          loadUserUseCase: mockLoadUserUseCase,
          createSaveUserUseCase: mockCreateSaveUserUseCase,
        );

        return newBloc;
      },
      seed: () => UserLoaded(userWithoutAddress),
      act: (bloc) => bloc.add(AddAddressEvent(address: testAddress)),
      expect: () => [
        isA<UserLoading>(),
        isA<UserLoaded>(),
        isA<UserLoading>(),
        isA<UserLoaded>(),
      ],
      verify: (_) {
        verify(() => mockCreateSaveUserUseCase(any())).called(2);
      },
    );

    blocTest<UserBloc, UserState>(
      'emits [UserError] when trying to add address to non-existent user',
      build: () => bloc,
      act: (bloc) => bloc.add(AddAddressEvent(address: testAddress)),
      expect: () => [
        isA<UserError>(),
      ],
    );
  });

  group('LoadCachedUser', () {
    test('attempts to load cached user on initialization', () async {
      // Override the default mock setup from setUp
      when(() => mockLoadUserUseCase(any()))
          .thenAnswer((_) async => Right(testUser));

      final newBloc = UserBloc(
        loadUserUseCase: mockLoadUserUseCase,
        createSaveUserUseCase: mockCreateSaveUserUseCase,
      );

      // Wait for the async operation to complete
      await Future.delayed(Duration.zero);

      // Verify the load was called and state was updated, it's twice as the bloc calls it once on init and once here
      verify(() => mockLoadUserUseCase(any())).called(2);
      expect(newBloc.state, isA<UserLoaded>());

      await newBloc.close();
    });

    test('starts in UserInitial when load fails', () async {
      // This test uses the default mock setup from setUp which returns Left(StorageFailure)
      // Just verify the state remains in UserInitial
      expect(bloc.state, isA<UserInitial>());
    });
  });
}
