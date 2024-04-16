import { supabase } from './supabase'

const LOCAL_STORAGE_SESSION_KEY = 'supabase.auth.session';
const LOCAL_STORAGE_USER_KEY = 'supabase.auth.user';

async function is_authenticated() {
    const session = await get_session();
    console.log('is_authenticated:', session !== undefined);
    return session !== undefined;
}

async function get_user() {
    const cachedUser = localStorage.getItem(LOCAL_STORAGE_USER_KEY);
    if (cachedUser) {
        return JSON.parse(cachedUser);
    }

    const {data: {user}, error} = await supabase.auth.getUser();
    if (error !== null || user === null) {
        return undefined;
    }

    set_user(user);
    return user;
}

async function get_session() {
    const cachedSession = localStorage.getItem(LOCAL_STORAGE_SESSION_KEY);
    if (cachedSession) {
        return JSON.parse(cachedSession);
    }

    const response = await supabase.auth.getSession();
    const {data: {session}, error} = response
    if (error !== null || session === null) {
        return undefined;
    }

    set_session(session);
    return session ? session : undefined;
}

function set_user(user) {
    localStorage.setItem(LOCAL_STORAGE_USER_KEY, JSON.stringify(user));
}

function set_session(session) {
    localStorage.setItem(LOCAL_STORAGE_SESSION_KEY, JSON.stringify(session));
}

function reset_local_storage() {
    localStorage.removeItem(LOCAL_STORAGE_USER_KEY);
    localStorage.removeItem(LOCAL_STORAGE_SESSION_KEY);
}

export {
    is_authenticated,
    get_user,
    get_session,
    set_user,
    set_session,
    reset_local_storage,
}