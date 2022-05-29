# AWS로 시작하는 인프라 구축의 정석 (샘플 애플리케이션)

이 프로젝트는 *13장. 샘플 애플리케이션*의 실행 코드이며 [*Ruby on Rails Tutorial*](https://www.learnenough.com/ruby-on-rails-6th-edition-tutorial)([Michael Hartl](http://www.michaelhartl.com/) 저)를 기준으로 작성되었습니다.

## 라이선스

[Ruby on Rails 튜토리얼(일본어)](https://railstutorial.jp/) 안에 있는 소스 코드는 MIT 라이선스와 Beerware 라이선스를 기반으로 공개되어 있습니다.

자세한 내용은 [LICENSE.md](LICENSE.md)를 참고합니다.

## 이용 방법

1. 먼저 이 저장소를 클론합니다.

```
# using HTTPS
$ git clone https://github.com/moseskim/aws-intro-sample.git

# using SSH
$ git clone git@github.com:moseskim/aws-intro-sample.git

# using GitHub CLI
$ gh repo clone moseskim/aws-intro-sample
```

2. 다음으로 필요한 RubyGems를 설치합니다.

```
$ bundle install --without production
```

3. 다음으로 데이터베이스를 마이그레이션합니다.

```
$ rails db:migrate
```

4. 마지막으로 테스트를 실행해 애플리케이션이 잘 동작하는지 확인합니다.

```
$ rails test
```

5. 테스트를 무사히 완료했다면, 이제 Rails 서버를 실행할 수 있습니다.

```
$ rails server
```
