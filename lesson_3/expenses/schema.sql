--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: expenses; Type: DATABASE; Schema: -; Owner: mell
--

CREATE DATABASE expenses WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE expenses OWNER TO mell;

\connect expenses

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: expenses; Type: TABLE; Schema: public; Owner: mell
--

CREATE TABLE expenses (
    id integer NOT NULL,
    amount numeric,
    memo text,
    created_on timestamp without time zone
);


ALTER TABLE expenses OWNER TO mell;

--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: mell
--

CREATE SEQUENCE expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expenses_id_seq OWNER TO mell;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mell
--

ALTER SEQUENCE expenses_id_seq OWNED BY expenses.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mell
--

ALTER TABLE ONLY expenses ALTER COLUMN id SET DEFAULT nextval('expenses_id_seq'::regclass);


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: mell
--



--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mell
--

SELECT pg_catalog.setval('expenses_id_seq', 1, false);


--
-- Name: expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: mell
--

ALTER TABLE ONLY expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: mell
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM mell;
GRANT ALL ON SCHEMA public TO mell;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

