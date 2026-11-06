# RAPTORS 3주년 라커룸

플래그풋볼 팀 RAPTORS 3주년 이벤트용 웹 메타버스입니다. 빌드 과정 없이 `index.html` 하나로 돌아가요.

## GitHub Pages로 배포하기

1. GitHub에서 새 저장소를 만들어요. 예: `raptors-3rd`
2. 이 폴더의 파일을 전부 올려요.
3. 저장소의 Settings > Pages에서 Source를 Deploy from a branch, 브랜치를 `main`, 폴더를 `/ (root)`로 지정해요.
4. 1~2분 뒤 `https://<아이디>.github.io/raptors-3rd/`에서 열려요.

## 콘텐츠 넣기

`index.html` 맨 위 스크립트의 `TEAM`과 `CONTENT`만 고치면 돼요.

- 팀 색과 연도: `TEAM` (레드 #E00000, 블랙, 화이트, 창단 2023)
- 유니폼 3종: `KITS` (레드, 블랙, 화이트 실제 유니폼 기준)
- 로고와 2023, 2026 그래픽은 `ASSETS`에 이미지로 들어 있어요
- 사진: `photos/` 폴더에 넣고 `src: 'photos/first-game.jpg'`처럼 적기 (긴 변 1600px 이하, jpg나 webp 권장)
- 명예의 전당: `CONTENT.trophies`의 제목과 설명

## 공유 링크 미리보기

카카오톡이나 슬랙에 링크를 붙였을 때 보이는 이미지는 `og:image`로 정해져요.
`photos/og.jpg`(1200x630 권장)를 올리고 `<head>`의 주석을 풀어서 절대 주소를 넣어주세요.

## 방명록을 모두가 같이 보게 하기 (Supabase)

연결하지 않으면 방명록은 각자 기기에만 저장돼요. 다 같이 보려면 아래처럼 연결해 주세요.

1. supabase.com에서 새 프로젝트를 만들어요.
2. SQL Editor에 `supabase.sql` 내용을 붙여넣고 실행해요.
3. Project Settings > API Keys에서 Project URL과 공개 키(publishable 또는 anon 키)를 복사해요.
4. `index.html`의 `GUESTBOOK`에 넣어요.
   ```js
   const GUESTBOOK = { supabaseUrl:'https://xxxx.supabase.co', supabaseKey:'공개 키', table:'guestbook' };
   ```
5. 다시 배포하면 끝이에요. 새 글은 15초마다 자동으로 보드에 반영돼요.
   같은 설정으로 QB Challenge 점수도 `qb_scores` 테이블에 저장되고, 필드 옆 TOP 5 보드에 표시돼요.

공개 키는 브라우저에 노출돼도 되는 키예요. 대신 service_role이나 secret 키는 절대 넣지 마세요.
부적절한 글은 Supabase 대시보드의 Table Editor에서 지울 수 있어요.

## 주의

- 공개 저장소의 사진은 누구나 볼 수 있어요. 얼굴이 나온 사진은 팀원들에게 미리 동의를 받아주세요.
- 캐릭터 꾸미기 값은 각자 기기에 저장돼요.
