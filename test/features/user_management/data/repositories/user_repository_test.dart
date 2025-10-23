import 'package:dartz/dartz.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/core/error/exceptions.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/core/error/failures.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/datasources/user_local_data_source.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/models/user_model.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/data/repositories/local/user_repository_impl.dart';
import 'package:double_vp_partners_prueba_tecnica_ricardo_ss/features/user_management/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class FakeUserModel extends Fake implements UserModel {}

void main() {
  late UserRepositoryImpl repository;
  late MockUserLocalDataSource mockLocalDataSource;

  setUpAll(() {
    registerFallbackValue(FakeUserModel());
  });

  setUp(() {
    mockLocalDataSource = MockUserLocalDataSource();
    repository = UserRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  final DateTime testDate = DateTime(2000, 1, 1);
  final testUser = UserEntity(
    firstName: 'John',
    lastName: 'Doe',
    birthDate: testDate,
  );
  final testUserModel = UserModel.fromEntity(testUser);

  group('createSaveUser', () {
    test(
      'should return Right(UserEntity) when save is successful',
      () async {
        // arrange
        when(() => mockLocalDataSource.saveCreateUser(any()))
            .thenAnswer((_) async {});

        // act
        final result = await repository.createSaveUser(testUser);

        // assert
        expect(result, isA<Right<Failure, UserEntity>>());
        verify(() => mockLocalDataSource.saveCreateUser(any())).called(1);
      },
    );

    test(
      'should return Left(StorageFailure) when storage operation fails',
      () async {
        // arrange
        when(() => mockLocalDataSource.saveCreateUser(any()))
            .thenThrow(StorageException(message: 'Error saving user'));

        // act
        final result = await repository.createSaveUser(testUser);

        // assert
        expect(result, isA<Left<Failure, UserEntity>>());
        expect((result as Left).value, isA<StorageFailure>());
        verify(() => mockLocalDataSource.saveCreateUser(any())).called(1);
      },
    );
  });

  group('loadUser', () {
    test(
      'should return Right(UserEntity) when local data exists',
      () async {
        // arrange
        when(() => mockLocalDataSource.loadUser())
            .thenAnswer((_) async => testUserModel);

        // act
        final result = await repository.loadUser();

        // assert
        expect(result, isA<Right<Failure, UserEntity>>());
        verify(() => mockLocalDataSource.loadUser()).called(1);
      },
    );

    test(
      'should return Left(StorageFailure) when no local data exists',
      () async {
        // arrange
        when(() => mockLocalDataSource.loadUser())
            .thenThrow(StorageException(message: 'User not found'));

        // act
        final result = await repository.loadUser();

        // assert
        expect(result, isA<Left<Failure, UserEntity>>());
        expect((result as Left).value, isA<StorageFailure>());
        verify(() => mockLocalDataSource.loadUser()).called(1);
      },
    );
  });
}
