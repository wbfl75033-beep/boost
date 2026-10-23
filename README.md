# 신입 FP 스타트 부스터 과정 · 설문

- 진단설문(입과 전): `pre-survey/index.html` (63문항) → `https://fppartners.vercel.app/pre-survey`
- 결과설문(수료 후): `post-survey/index.html` (76문항) → `https://fppartners.vercel.app/post-survey`
- 두 설문 모두 같은 Supabase 프로젝트의 `survey_responses` 테이블에 저장됨, `survey` 컬럼으로 구분(`diagnostic`/`outcome`)
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
