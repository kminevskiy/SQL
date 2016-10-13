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
-- Name: lists; Type: TABLE; Schema: public; Owner: mell
--

CREATE TABLE lists (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE lists OWNER TO mell;

--
-- Name: list_id_seq; Type: SEQUENCE; Schema: public; Owner: mell
--

CREATE SEQUENCE list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE list_id_seq OWNER TO mell;

--
-- Name: list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mell
--

ALTER SEQUENCE list_id_seq OWNED BY lists.id;


--
-- Name: todos; Type: TABLE; Schema: public; Owner: mell
--

CREATE TABLE todos (
    id integer NOT NULL,
    list_id integer NOT NULL,
    name character varying(255) NOT NULL,
    completed boolean DEFAULT false NOT NULL
);


ALTER TABLE todos OWNER TO mell;

--
-- Name: todos_id_seq; Type: SEQUENCE; Schema: public; Owner: mell
--

CREATE SEQUENCE todos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE todos_id_seq OWNER TO mell;

--
-- Name: todos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mell
--

ALTER SEQUENCE todos_id_seq OWNED BY todos.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mell
--

ALTER TABLE ONLY lists ALTER COLUMN id SET DEFAULT nextval('list_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mell
--

ALTER TABLE ONLY todos ALTER COLUMN id SET DEFAULT nextval('todos_id_seq'::regclass);


--
-- Name: list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mell
--

SELECT pg_catalog.setval('list_id_seq', 1, false);


--
-- Data for Name: lists; Type: TABLE DATA; Schema: public; Owner: mell
--

COPY lists (id, name) FROM stdin;
\.


--
-- Data for Name: todos; Type: TABLE DATA; Schema: public; Owner: mell
--

COPY todos (id, list_id, name, completed) FROM stdin;
\.


--
-- Name: todos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mell
--

SELECT pg_catalog.setval('todos_id_seq', 1, false);


--
-- Name: list_name_key; Type: CONSTRAINT; Schema: public; Owner: mell
--

ALTER TABLE ONLY lists
    ADD CONSTRAINT list_name_key UNIQUE (name);


--
-- Name: list_pkey; Type: CONSTRAINT; Schema: public; Owner: mell
--

ALTER TABLE ONLY lists
    ADD CONSTRAINT list_pkey PRIMARY KEY (id);


--
-- Name: todos_pkey; Type: CONSTRAINT; Schema: public; Owner: mell
--

ALTER TABLE ONLY todos
    ADD CONSTRAINT todos_pkey PRIMARY KEY (id);


--
-- Name: todos_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mell
--

ALTER TABLE ONLY todos
    ADD CONSTRAINT todos_list_id_fkey FOREIGN KEY (list_id) REFERENCES lists(id);


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

