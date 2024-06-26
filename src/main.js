import './assets/main.css'

import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'

import App from '@/App.vue'
import Account from '@/components/Account.vue'
import LandingPage from '@/components/LandingPage.vue'
import Login from '@/components/Login.vue'
import { is_authenticated, reset_local_storage, set_session } from '@/authentication'
import { supabase } from '@/supabase'
import Dashboard from '@/components/Dashboard.vue'
import DateFilter from '@/components/search/DateSearch.vue'
import Register from '@/components/Register.vue'
import DateIdea from '@/components/DateIdea.vue'

import Toast from 'vue-toastification'
import 'vue-toastification/dist/index.css'

const router = createRouter({
	history: createWebHistory('/date-finder/'),
	routes: [
		{ path: '/find', component: DateFilter, meta: { requiresAuth: true } },
		{ path: '/account', component: Account, meta: { requiresAuth: true } },
		{ path: '/idea/:id', component: DateIdea, meta: { requiresAuth: true }, name: 'idea' },

		{ path: '/login', component: Login },
		{ path: '/register', component: Register },
		{ path: '/dashboard', component: Dashboard, meta: { requiresAuth: true } },
		{ path: '/', component: LandingPage, name: 'landing' },
		{ path: '/:pathMatch(.*)*', redirect: { name: 'landing' } },
	],
})

router.beforeEach(async (to, from, next) => {
	const requiresAuth = to.matched.some((record) => record.meta.requiresAuth)
	const authenticated = await is_authenticated()

	if (requiresAuth && !authenticated) {
		// Redirect unauthenticated users trying to access protected routes to the login page
		console.log('Redirecting to login: Access to protected route requires authentication.')
		next('/login')
	} else if ((to.path === '/login' || to.path === '/register') && authenticated) {
		// Redirect authenticated users trying to access the login page to the dashboard
		console.log('Redirecting to dashboard: Already authenticated.')
		next('/dashboard')
	} else if (to.path === '/' && authenticated) {
		// Redirect authenticated users accessing the root to the dashboard
		console.log('Redirecting to dashboard: Authenticated user at root.')
		next('/dashboard')
	} else {
		// Proceed with the normal route
		next()
	}
})

// Listen for changes to authentication from supabase
supabase.auth.onAuthStateChange(async (event, session) => {
	if (event === 'SIGNED_OUT') {
		console.log('SUPABASE EVENT: SIGNED_OUT')
		reset_local_storage()
	} else if (event === 'SIGNED_IN') {
		console.log('SUPABASE EVENT: SIGNED_IN')
		console.log('SUPABASE SESSION:', session)
		set_session(session)
	} else if (event === 'INITIAL_SESSION') {
		console.log('SUPABASE EVENT: INITIAL_SESSION')
	} else {
		console.log('SUPABASE EVENT:', event)
	}
})

const app = createApp(App)
app.use(router)
app.use(Toast, {
	timeout: 2500,
	position: 'top-center',
	pauseOnHover: true,
	closeOnClick: true,
})
app.mount('#app')
