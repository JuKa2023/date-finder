import { createApp } from 'vue'
import{createRouter, createWebHistory} from 'vue-router'

import App from './App.vue'
import Account from './components/Account.vue'
import LandingPage from './components/LandingPage.vue'
import Login from './components/Login.vue'
import { supabase } from './supabase'


const REDIRECT_UNAUTHENTICATED = false

const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/account', component: Account, meta: { requiresAuth: true } },
        { path: '/:pathMatch(.*)*', component: LandingPage },
        { path: '/login', component: Login }
    ]
})

router.beforeEach((to, from, next) => {
    const requiresAuth = to.matched.some(record => record.meta.requiresAuth);
    const session = supabase.auth.getSession()
    const user = session?.user;

    if (requiresAuth && (!session || !user) && REDIRECT_UNAUTHENTICATED) {
        console.log('requiresAuth', requiresAuth);
        next('/login');
    } else {
        next();
    }
});

const app = createApp(App)
app.use(router)

app.mount('#app')