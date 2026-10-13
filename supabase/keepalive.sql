-- 무료 요금제 프로젝트가 7일 비활동으로 자동 정지(pause)되는 걸 막기 위한 설정
-- 매일 한 번, DB에 실제 쿼리(가벼운 조회)를 날려서 "활동 중"으로 유지시킴
-- Supabase SQL Editor에서 한 번만 실행하면 계속 자동으로 돌아감

-- pg_cron 확장 기능 활성화
create extension if not exists pg_cron with schema extensions;

-- 매일 한국 시간 낮 12시(UTC 03:00)에 가벼운 조회 쿼리 실행
select cron.schedule(
  'keepalive-daily',
  '0 3 * * *',
  $$ select count(*) from public.survey_responses; $$
);

-- 확인용: 아래 쿼리로 예약된 작업 목록을 볼 수 있음
-- select * from cron.job;

-- 확인용: 아래 쿼리로 실제 실행 기록을 볼 수 있음
-- select * from cron.job_run_details order by start_time desc limit 10;

-- 나중에 이 기능을 끄고 싶으면:
-- select cron.unschedule('keepalive-daily');
