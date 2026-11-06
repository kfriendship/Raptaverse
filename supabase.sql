-- RAPTORS 3주년 방명록 테이블
-- Supabase 대시보드 > SQL Editor에 붙여넣고 Run을 누르세요.

create table if not exists public.guestbook (
  id bigint generated always as identity primary key,
  name text not null check (char_length(name) between 1 and 30),
  text text not null check (char_length(text) between 1 and 60),
  created_at timestamptz not null default now()
);

alter table public.guestbook enable row level security;

-- 누구나 읽기
create policy "guestbook read" on public.guestbook
  for select to anon using (true);

-- 누구나 쓰기 (길이 제한은 위 check 조건이 막아줘요)
create policy "guestbook insert" on public.guestbook
  for insert to anon with check (true);

-- 수정과 삭제 정책은 일부러 만들지 않았어요.
-- 부적절한 글은 대시보드 Table Editor에서 직접 지우면 돼요.

-- QB Challenge 리더보드
create table if not exists public.qb_scores (
  id bigint generated always as identity primary key,
  name text not null check (char_length(name) between 1 and 30),
  score int not null check (score between 0 and 30),
  created_at timestamptz not null default now()
);

alter table public.qb_scores enable row level security;

create policy "qb read" on public.qb_scores
  for select to anon using (true);

create policy "qb insert" on public.qb_scores
  for insert to anon with check (true);
