create database job_application_forms;

create table basic_detail (
applicant_id int primary key auto_increment,
applicant_firstName varchar(50) not null,
applicant_lastName varchar(50) not null,
applicant_phoneNumber varchar(20) not null unique,
applicant_email varchar(100) not null unique,
applicant_address1 varchar(100) not null,
applicant_address2 varchar(100) not null,
applicant_city varchar(20) not null,
applicant_state varchar(20) not null,
applicant_zipcode varchar(6) not null,
applicant_gender varchar(6) not null,        #male, female or others
applicant_relationshipStatus varchar(20) not null,       #Single, Married, Divorced, Others
applicant_dateOfBirth date not null,
created_at datetime default current_timestamp,
updated_at datetime default current_timestamp on update current_timestamp

constraint chk_basicDetail_applicantGender check(applicant_gender in ('male', 'female'))
constraint chk_basicDetail_applicantRelationshipStatus check(applicant_relationshipStatus in ('single', 'married', 'divorced', 'others'))
);


create table education_detail (
education_id int auto_increment primary key,
applicant_id int,
education_passoutYear smallint not null,
education_percentage decimal(4,2) not null,

constraint fk_educationDetail_applicantId foreign key(applicant_id) references basic_detail(applicant_id),

constraint chk_educationDetail_educationPercentage check(education_percentage between 0 and 100)
);
create index idx_educationDetail_applicantId
on education_detail(applicant_id);


create table work_experience (
experience_id int auto_increment primary key,
applicant_id int,
company_name varchar(50) not null,
from_date date not null,
to_date date not null,
annual_package decimal(10,2) not null,
reason_to_leave varchar(100) not null,
reference_contact_number varchar(20) not null,
reference_contact_name varchar(20) not null,

constraint fk_workExperience_applicantId foreign key(applicant_id) references basic_detail(applicant_id),

constraint chk_workExperience__fromDate_ToDate check(from_date <= to_date)
);
create index idx_workExperience_applicantId
on work_experience(applicant_id);


create table language_known (
language_id int auto_increment primary key,
applicant_id int,
language_name varchar(20) not null,
language_read varchar(30) null,
language_write varchar(30) null,
language_speak varchar(30) null,

constraint fk_languageKnown_applicantId foreign key(applicant_id) references basic_detail(applicant_id)
);
create index idx_languageKnown_applicantId
on language_known(applicant_id);



create table technology_known (
technology_id int auto_increment primary key,
applicant_id int,
technology_name varchar(20) not null,
level_of_technology_known varchar(10) not null,           # beginner, mediator, expert

constraint fk_technologyKnown_applicantId foreign key(applicant_id) references basic_detail(applicant_id),

constraint chk_technologyKnown_levelOfTechnologyKnown check(level_of_technology_known in ('beginner', 'mediator', 'expert'))
);
create index idx_technologyKnown_applicantId
on technology_known(applicant_id);


create table reference_contact (
reference_id int auto_increment primary key,
applicant_id int,
reference_name varchar(20) not null,
reference_contact_number varchar(20) not null,
reference_contact_relation varchar(20) not null,

constraint fk_referenceContact_applicantId foreign key(applicant_id) references basic_detail(applicant_id)
);
create index idx_referenceContact_applicantId
on reference_contact(applicant_id);

create table preferences(
preference_id int auto_increment primary key,
applicant_id int,
prefered_location varchar(20) not null,
notice_period smallint not null,
expected_ctc int not null,
current_ctc int not null,
department varchar(20) not null,

constraint fk_preference_applicantId foreign key(applicant_id) references basic_detail(applicant_id)
);
create index idx_preference_applicationId
on preference(application_id);