BEGIN;

CREATE TABLE IF NOT EXISTS mergestat.saved_queries(
    id uuid PRIMARY KEY DEFAULT public.gen_random_uuid() NOT NULL,
    created_by text,
    created_at timestamp with time zone,
    name text,
    sql text,
    metadata jsonb
);

-- enable RLS 
ALTER TABLE mergestat.saved_queries ENABLE ROW LEVEL SECURITY;

-- creates an RLS policy that give ALL permissions to saved_queries rows that current_user matches created_by column.
CREATE POLICY saved_queries_all_access ON mergestat.saved_queries FOR ALL USING(created_by = current_user);

-- creates an RLS policy that gives admin level users ALL permission to saved_queries table.
CREATE POLICY saved_queries_all_access_admin ON mergestat.saved_queries FOR ALL TO mergestat_role_admin USING(TRUE);

-- creates an RLS policy that gives every role the SELECT permission to saved_queries table.
CREATE POLICY saved_queries_all_view ON mergestat.saved_queries FOR SELECT USING (TRUE);

-- GRANT the ability to mergestat_role_user role to INSERT, UPDATE AND DELETE on table saved_queries.
GRANT INSERT, UPDATE, DELETE ON TABLE mergestat.saved_queries TO mergestat_role_user;

COMMIT;
