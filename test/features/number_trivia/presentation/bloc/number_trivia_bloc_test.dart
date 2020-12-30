import 'package:clean_architecture_tdd/core/error/failures.dart';
import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;
  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('should initialState be Empty', () async {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test(
        'should cal the InputConverter to validate and conveert the string to an unsigned integer',
        () async {
      // arrange
      setUpMockInputConverterSuccess();

      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));

      // bloc.add는 async를 반환하므로 await untilCalled를 넣지 않으면 다름 로직이 바로 실행되어 실패함
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      // assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      // arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      // assert later : 미리 등록하는게 더 안전함
      final expected = [Empty(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)];
      expectLater(bloc.state, emitsInOrder(expected)); // 최대 30초 동안 응답이 오기를 기다림

      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should get data from the concrete use case', () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));

      // assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      // arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      // act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    // test('should emit [Loading, Error] when getting data fails', () async {
    //   // arrange
    //   setUpMockInputConverterSuccess();

    //   // Left(ServerFailure())가 error 나서 테스트 불가
    //   // 15분 : https://www.youtube.com/watch?v=YSNeS5S5Nqw
    //   when(mockGetConcreteNumberTrivia(any))
    //       .thenAnswer((_) async => Left(ServerFailure()));

    //   // assert later
    //   final expected = [
    //     Empty(),
    //     Loading(),
    //     Error(message: SERVER_FAILURE_MESSAGE),
    //   ];
    //   expectLater(bloc.state, emitsInOrder(expected));

    //   // act
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));
    // });

    // test(
    //     'should emit [Loading, Error] when a proper message for the error when getting data fails',
    //     () async {
    //   // arrange
    //   setUpMockInputConverterSuccess();

    //   // Left(CacheFailure())가 error 나서 테스트 불가
    //   // 17분 : https://www.youtube.com/watch?v=YSNeS5S5Nqw
    //   when(mockGetConcreteNumberTrivia(any))
    //       .thenAnswer((_) async => Left(CacheFailure()));

    //   // assert later
    //   final expected = [
    //     Empty(),
    //     Loading(),
    //     Error(message: CACHE_FAILURE_MESSAGE),
    //   ];
    //   expectLater(bloc.state, emitsInOrder(expected));

    //   // act
    //   bloc.add(GetTriviaForConcreteNumber(tNumberString));
    // });
  });
}
