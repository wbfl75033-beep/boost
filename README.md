# 신입 FP 스타트 부스터 과정 · 설문

- 진단설문(입과 전): `pre-survey/index.html` (66문항, v8) → `https://fppartners.vercel.app/pre-survey`
- 결과설문(수료 후): `post-survey/index.html` (76문항, v19) → `https://fppartners.vercel.app/post-survey`
- 랜딩페이지: `landing/index.html` (이미지 내장, 견본 PDF는 `landing/files/`) → 배포 브랜치에 합쳐지면 `https://fppartners.vercel.app/landing`
- 수료증 발급기: `certificate/index.html` (한 명씩 입력 → 바탕 `template.png` 위에 그려 PNG/PDF로 저장, 서버·DB 없음, 이전 기록은 브라우저(localStorage)에만 보관, 디자인은 랜딩과 동일) → `https://fppartners.vercel.app/certificate`
  - 글자 위치·크기는 `index.html` 안의 `const L = {...}` 한 곳에서 조정
- 두 설문 모두 같은 Supabase 프로젝트의 `survey_responses` 테이블에 저장됨, `survey` 컬럼으로 구분(`diagnostic`/`outcome`), `version` 컬럼으로 문항 버전 구분
- 링크는 영구히 고정, 문항 내용만 계속 바뀜 → 조회/내보내기는 설문별 + 버전별로 분리
  - 진단설문: `survey_responses_readable`(63문항 구버전, v6 이하) / `"진단설문"`(66문항, v8부터)
  - 결과설문: `survey_responses_readable_outcome`(구버전) / `"결과설문"`(76문항, v19부터)
  - 문항이 또 바뀌면 새 버전명으로 뷰를 하나 더 추가하면 됨(기존 응답·뷰는 그대로 둠)
- 테이블/보안 정책 SQL: `supabase/schema.sql`
- 배포: Vercel (`fppartners` 팀 프로젝트, 도메인 `fppartners.vercel.app`, 이 브랜치에 push하면 자동 재배포)
  → 다음 설문(전문위원 소견 등)도 같은 프로젝트에 새 폴더를 추가하면 됨

## 배포 전 체크리스트

1. Supabase SQL Editor에서 `supabase/schema.sql` 내용을 그대로 실행 (테이블 생성 + RLS)
2. Table Editor에서 `survey_responses` 옆에 **RLS enabled** 표시 확인
3. `pre-survey/index.html`을 정적 호스팅에 배포
4. 배포된 링크를 휴대폰으로 열어 끝까지 응답 → 제출 → Table Editor에 행이 생기는지 확인
5. 테스트 응답 행은 확인 후 삭제
6. `supabase/keepalive.sql` 실행 — 무료 요금제 프로젝트의 7일 비활동 자동 정지 방지
7. 문항이 바뀌어 새 버전 뷰를 추가할 때는 `supabase/view_진단설문.sql`, `supabase/view_결과설문.sql`처럼 SQL Editor에서 그대로 실행
