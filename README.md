# Flutter Clean Architecture & TDD
![flutter clean architecture](https://trello-attachments.s3.amazonaws.com/5fe87c8780781a6ad73871c5/530x646/b53cb45d90b5cb4546f9985363f469c2/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2020-12-27_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_9.16.08.png)

- directory structure
```dart
lib
  core
    error
    platform
    usecases

  features
    feature
      data
        datasources : local 및 remote에서 받아오는 데이터에 대한 abstract
        models : entity를 확장함
        repositories : data layer의 brain 역할
      domain
        entities
        repositories : data / repositories에 대한 abstract
        usecases : 해당 도메인에 대한 기능
      presentation
        block
        pages
        widgets
```

## Clean Architecture
![clean architecture](https://trello-attachments.s3.amazonaws.com/5c47e778dc999b7f99c70736/5fe87c8780781a6ad73871c5/d1714a84d736d802c7f73ec655a84cde/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2020-12-27_%EC%98%A4%ED%9B%84_11.05.32.png)
- 바깥 레이어들은 안쪽 레이어에 의존성을 가짐
- 구현시 안쪽 레이어 부터 구현해야함

## TDD
- 개발 순서(RED -> Green -> Refactor)
  - Clean Architecture의 out layer에 대한 abstract class를 구현
  - `when`을 이용하여 out layer의 응답을 `moacking`하도록 테스트 환경 구성
  - 해당 응답에 따라 테스트하고자 하는 기능의 상태를 `assert` 함 -> RED
  - 위의 `assert`가 성공하도록 실제 코드를 작성 -> GREEN

- Test Coverage
  - 단위 테스트(unit testing)
    - API 기능 테스트 : 외부와 통신하면 안됨 (통신 결과를 json 형태의 파일로 만들어 테스트)
  - 통합 테스트(integration testing)

- use packages
  - [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
  - [mockito](https://pub.dev/packages/mockito)
```dart
group : 특정 상태를 그룹으로 생성. 하위 그룹을 가질 수 있음
test : 원하는 테스트를 작성. 테스트 이름은 `should ~ when ~` 형태가 좋음.
when : 해당 기능이 호출되었을 때의 동작을 정의
verify : 기능이 호출되었는지 확인
verifyZeroInteractions : 기능이 호출 안되었는지 확인
```

## API
- [number trivia API](http://numbersapi.com/)

## Reference
- Flutter TDD Clean Architecture Course
  - [[1] – Explanation & Project Structure](https://www.youtube.com/watch?v=KjE2IDphA_U)
  - [[2] – Entities & Use Cases](https://www.youtube.com/watch?v=lPkWX8xFthE)
  - [[3] – Domain Layer Refactoring](https://www.youtube.com/watch?v=Mmq72a0h4jk)
  - [[4] – Data Layer Overview & Models](https://www.youtube.com/watch?v=keaTZ9M_U1A)
  - [[5] – Contracts of Data Sources](https://www.youtube.com/watch?v=m_lkZo6CYcs)
  - [[6] – Repository Implementation](https://www.youtube.com/watch?v=bfEKPKKy9dA)
  - [[7] – Network Info](https://www.youtube.com/watch?v=xWl7GzMDiwg)
  - [[8] – Local Data Source](https://www.youtube.com/watch?v=fCguzcvLka8)
  - [[9] – Remote Data Source](https://www.youtube.com/watch?v=msGsYPtZnhU)
  - [[10] – Bloc Scaffolding & Input Conversion](https://www.youtube.com/watch?v=Ulk9qUErIa4)
  - [[11] – Bloc Implementation 1/2](https://www.youtube.com/watch?v=a8f_qpVHa3w)
  - [[12] – Bloc Implementation 2/2](https://www.youtube.com/watch?v=YSNeS5S5Nqw)
  - [[13] – Dependency Injection](https://www.youtube.com/watch?v=gfLb4rqzio4)
  - [[14] – User Interface](https://www.youtube.com/watch?v=G-R-1rzR3zw)
