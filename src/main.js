import { createApp } from 'vue'
import{createRouter, createWebHistory} from 'vue-router'

import App from './App.vue'
import Account from './components/Account.vue'

const router = createRouter({
    history: createWebHistory(),
    routes: [
        { path: '/account', component: Account },
    ]
})

const app = createApp(App)

app.use(router)

app.mount('#app')