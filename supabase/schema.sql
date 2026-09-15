-- 진단설문(survey) 응답 저장 테이블
-- Supabase SQL Editor에서 그대로 실행하면 됩니다.

create table public.survey_responses (
  id           uuid primary key default gen_random_uuid(),
  survey       text        not null,   -- 어떤 설문인지 ('diagnostic' = 진단설문)
  version      text,                   -- 설문 버전 ('v6')
  name         text,                   -- 성명
  phone        text,                   -- 휴대전화번호
  company      text,                   -- 소속 회사·지점
  answers      jsonb       not null,   -- 63문항 응답 전체
  submitted_at timestamptz not null default now()
);

create index on public.survey_responses (survey, submitted_at);
create index on public.survey_responses (phone);

-- 보안 잠금을 켠다
alter table public.survey_responses enable row level security;

-- 누구나 '제출'은 할 수 있다 (설문 응답)
create policy "anyone can submit"
  on public.survey_responses
  for insert
  to anon
  with check (true);

-- 읽기·수정·삭제 정책은 만들지 않는다 → 아무도 못 한다 (관리자는 콘솔 로그인으로 조회)
