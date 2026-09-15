-- 진단설문 응답을 사람이 보기 편하게 63문항을 열로 펼친 읽기 전용 뷰
-- survey_responses 테이블 자체는 건드리지 않음 (문항이 바뀌어도 이 뷰만 다시 만들면 됨)
-- Supabase SQL Editor에서 그대로 실행하면 Table Editor에 survey_responses_readable로 나타남

create or replace view public.survey_responses_readable as
select
  submitted_at                as 제출시각,
  name                        as 성명,
  phone                       as 연락처,
  company                     as 소속,
  answers->>'1'  as "1_동의여부",
  answers->>'5'  as "5_이전직업",
  answers->>'6'  as "6_경력기간",
  answers->>'7'  as "7_보험업무경험",
  answers->>'8'  as "8_겸업여부",
  answers->>'9'  as "9_주당학습시간",
  answers->>'10' as "10_생손보차이",
  answers->>'11' as "11_실손구조",
  answers->>'12' as "12_암뇌심장차이",
  answers->>'13' as "13_연금저축구조",
  answers->>'14' as "14_계약순서",
  answers->>'15' as "15_고지의무",
  answers->>'16' as "16_암보험즉시OX",
  answers->>'17' as "17_종신정기차이OX",
  answers->>'18' as "18_실손전액OX",
  answers->>'19' as "19_실손중복OX",
  answers->>'20' as "20_간병동일OX",
  answers->>'21' as "21_국민연금부족OX",
  answers->>'22' as "22_병력미고지OX",
  answers->>'23' as "23_전세화재배상OX",
  answers->>'24' as "24_기본급OX",
  answers->>'25' as "25_위촉계약OX",
  answers->>'26' as "26_해지환수OX",
  answers->>'27' as "27_등록시험신청OX",
  answers->>'28' as "28_갈아타기OX",
  answers->>'29' as "29_대납보험료OX",
  answers->>'30' as "30_명의대여OX",
  answers->>'31' as "31_미고지안내OX",
  answers->>'32' as "32_선택이유설명",
  answers->>'33' as "33_선택만족",
  answers->>'34' as "34_주변알림부담",
  answers->>'35' as "35_고객도움인식",
  answers->>'36' as "36_6개월지속의향",
  answers->>'37' as "37_어려워도해낼자신",
  answers->>'38' as "38_인맥발굴자신감",
  answers->>'39' as "39_전화약속자신감",
  answers->>'40' as "40_니즈파악자신감",
  answers->>'41' as "41_소개요청자신감",
  answers->>'42' as "42_일정계획습관",
  answers->>'43' as "43_기록습관",
  answers->>'44' as "44_지속력",
  answers->>'45' as "45_연락가능인원",
  answers->>'46' as "46_보험이야기가능인원",
  answers->>'47' as "47_주변직업군",
  answers->>'48' as "48_모임여부",
  answers->>'49' as "49_모임성격",
  answers->>'50' as "50_거절회복력",
  answers->>'51' as "51_냉담반응민감도",
  answers->>'52' as "52_재연락어려움",
  answers->>'53' as "53_자기개방성",
  answers->>'54' as "54_낯선사람편안함",
  answers->>'55' as "55_지속성",
  answers->>'56' as "56_반복지루함",
  answers->>'57' as "57_목표지향성",
  answers->>'58' as "58_6개월후구체성",
  answers->>'59' as "59_감정캐치",
  answers->>'60' as "60_해결책선호",
  answers->>'61' as "61_학습주도성",
  answers->>'62' as "62_익숙함선호",
  answers->>'63' as "63_목표한줄"
from public.survey_responses
where survey = 'diagnostic'
order by submitted_at desc;

-- 뷰가 RLS를 우회하지 못하도록 잠금 (핵심)
-- 이게 없으면 anon 공개 키만으로 이 뷰의 모든 응답을 누구나 읽을 수 있음
alter view public.survey_responses_readable set (security_invoker = true);

-- 혹시 몰라 이중으로 익명/일반 사용자 접근을 명시적으로 차단
revoke all on public.survey_responses_readable from anon, authenticated;
