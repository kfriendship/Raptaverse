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

-- 방문자(anon)가 읽고 쓸 수 있게 권한 부여. 없으면 HTTP 401 "permission denied" 발생
grant select, insert on public.guestbook to anon;
grant select, insert on public.qb_scores to anon;

-- 내가 쓴 방명록 지우기 (로그인 없이 브라우저별 비밀 토큰으로 본인 확인)
alter table public.guestbook add column if not exists owner text;

-- owner 토큰은 다른 사람이 못 보게 owner 열만 빼고 읽기 허용
revoke select on public.guestbook from anon;
grant select (id, name, text, created_at) on public.guestbook to anon;

create or replace function public.delete_guestbook(p_id bigint, p_owner text)
returns boolean language sql security definer set search_path = public as $$
  with d as (delete from public.guestbook where id = p_id and owner = p_owner and p_owner is not null returning 1)
  select exists(select 1 from d);
$$;
revoke all on function public.delete_guestbook(bigint, text) from public;
grant execute on function public.delete_guestbook(bigint, text) to anon;
