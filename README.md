# Ruby on Rails 튜토리얼 샘플 애플리케이션

이 프로젝트는 다음 교재에 따라 만든 샘플 애플리케이션입니다.

[*Ruby on Rails Tutorial*](https://railstutorial.jp/)

[Michael Hartl](http://www.michaelhartl.com/) 著

## 라이선스

[Ruby on Rails 튜토리얼チュートリアル](https://railstutorial.jp/) 안에 있는 소스 코드는 MIT 라이선스와 Beerware 라이선스를 기반으로 공개되어 있습니다.
자세한 내용은 [LICENSE.md](LICENSE.md)를 참고합니다.

## 이용 방법

이 애플리케이션을 동작시킬 때는 먼저 저장소를 클론합니다.

이후 다음 명령어를 실행해 필요한 RubyGems를 설치합니다.

```
$ bundle install --without production
```

다음으로 데이터베이스를 마이그레이션합니다.

```
$ rails db:migrate
```

마지막으로 테스트를 실행해 애플리케이션이 잘 동작하는지 확인합니다.

```
$ rails test
```

테스트가 무사히 완료되었다면 Rails 서버를 실행할 수 있습니다.

```
$ rails server
```

자세한 내용은 [*Ruby on Rails チュートリアル*](https://railstutorial.jp/)를 참조하기 바랍니다.
