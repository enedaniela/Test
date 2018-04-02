CREATE table "STATUSES" (
    "STATUS_ID"   NUMBER(3),
    "DESCRIPTION" VARCHAR2(200),
    constraint  "STATUSES_PK" primary key ("STATUS_ID")
)
/

CREATE table "PRIORITIES" (
    "PRIORITY_ID" NUMBER(3),
    "DESCTIPTION" VARCHAR2(200),
    constraint  "PROPERTIES_PK" primary key ("PROPERTY_ID")
)
/

CREATE table "PROJECTS" (
    "PROJECT_ID"   NUMBER(3),
    "PROJECT_NAME" VARCHAR2(200),
    "FLAG_DEL"     NUMBER(1),
    "DESCRIPTION"  VARCHAR2(1000),
    constraint  "PROJECTS_PK" primary key ("PROJECT_ID")
)
/

alter table "PROJECTS" add
constraint "FLAG_DEL_CK" 
check (FLAG_DEL IN (1, 0))
/   

CREATE table "USERS" (
    "USER_ID"     NUMBER(5),
    "USERNAME"    VARCHAR2(100),
    "FIRST_NAME"  VARCHAR2(100),
    "SECOND_NAME" VARCHAR2(100),
    "PASSWORD"    VARCHAR2(100),
    "FLAG_DEL"    NUMBER(1),
    constraint  "USERS_PK" primary key ("USER_ID")
)
/

alter table "USERS" add
constraint "FLAG_DEL_USERS_CK" 
check (FLAG_DEL IN (0, 1))
/   

CREATE table "ASSOC_USERS_PROJECTS" (
    "ASSOC_ID"   NUMBER(5),
    "USER_ID"    NUMBER(5),
    "PROJECT_ID" NUMBER(3),
    "FLAG_DEL"   NUMBER(1),
    constraint  "ASSOC_USERS_PROJECTS_PK" primary key ("ASSOC_ID")
)
/

ALTER TABLE "ASSOC_USERS_PROJECTS" ADD CONSTRAINT "ASSOC_USERS_PROJECTS_USERS_FK" 
FOREIGN KEY ("USER_ID")
REFERENCES "USERS" ("USER_ID")

/
ALTER TABLE "ASSOC_USERS_PROJECTS" ADD CONSTRAINT "ASSOC_USERS_PROJECTS_FK" 
FOREIGN KEY ("PROJECT_ID")
REFERENCES "PROJECTS" ("PROJECT_ID")

/
alter table "ASSOC_USERS_PROJECTS" add
constraint "FLAG_DEL_ASSOC_CK" 
check (FLAG_DEL IN (0, 1))
/ 


CREATE table "TASKS" (
    "TASK_ID"     NUMBER(10),
    "PROJECT_ID"  NUMBER(3),
    "NAME"        VARCHAR2(200),
    "DESCRIPTION" VARCHAR2(4000),
    "STATUS_ID"   NUMBER(3),
    "PRIORITY_ID" NUMBER(3),
    "USER_ID"     NUMBER(5),
    constraint  "TASKS_PK" primary key ("TASK_ID")
)
/

ALTER TABLE "TASKS" ADD CONSTRAINT "TASKS_PROJECTS_FK" 
FOREIGN KEY ("PROJECT_ID")
REFERENCES "PROJECTS" ("PROJECT_ID")

/
ALTER TABLE "TASKS" ADD CONSTRAINT "TASKS_STATUSES_FK" 
FOREIGN KEY ("STATUS_ID")
REFERENCES "STATUSES" ("STATUS_ID")

/
ALTER TABLE "TASKS" ADD CONSTRAINT "TASKS_USERS_FK" 
FOREIGN KEY ("USER_ID")
REFERENCES "USERS" ("USER_ID")

/


CREATE table "COMMENTS" (
    "COMMENT_ID"   NUMBER(10),
    "TASK_ID"      NUMBER(10),
    "COMMENT_TEXT" VARCHAR2(4000),
    "PUBLISH_DATE" DATE,
    constraint  "COMMENTS_PK" primary key ("COMMENT_ID")
)
/

ALTER TABLE "COMMENTS" ADD CONSTRAINT "COMMENTS_TASKS_FK" 
FOREIGN KEY ("TASK_ID")
REFERENCES "TASKS" ("TASK_ID")

/

alter table "TASKS" add constraint
"TASKS_PRIORITIES_FK" foreign key ("PRIORITY_ID") references "PRIORITIES" ("PRIORITY_ID")
/   


CREATE table "USERS_ROLES" (
    "ROLE_ID"     NUMBER(3),
    "DESCRIPTION" VARCHAR2(100),
    constraint  "USERS_ROLES_PK" primary key ("ROLE_ID")
)
/

alter table "ASSOC_USERS_PROJECTS" add
("ROLE_ID" NUMBER(3) NOT NULL)
/   

alter table "ASSOC_USERS_PROJECTS" add constraint
"ASSOC_USERS_PROJECTS_ROLES_FK" foreign key ("ROLE_ID") references "USERS_ROLES" ("ROLE_ID")
/   

