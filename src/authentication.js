import { supabase } from './supabase'

async function login(email, password) {
    if (is_authenticated()) {
        console.log('Already logged in');
        // router.push('/account');
        return;
    }

    try {
        const { error } = await supabase.auth.signInWithPassword({
            email: email.value,
            password: password.value,
        })

        if (error) throw error;
    
        localStorage.setItem('user', JSON.stringify(user));    
        // router.push('/account');
        

    } catch (error) {
        console.error('Login failed:', error.message);
    }
}

async function is_authenticated() {
    const user = localStorage.getItem('user');
    if (user) {
        return true;
    }

    const data = await supabase.auth.getSession();
    const session = data?.session;
    if (session) {
        localStorage.setItem('user', JSON.stringify(session.user));
    }
    return !!session;
}

async function logout() {
    try {
        localStorage.removeItem('user');
        const { error } = await supabase.auth.signOut();
        if (error) throw error;
        // router.push('/login');
    } catch (error) {
        console.error('Logout failed:', error.message);
    }
}

export { login, is_authenticated, logout }