<template>
    <form class="row flex-center flex" @submit.prevent="handleLogin">
        <div class="col-6 form-widget">
            <h1 class="header">Supabase + Vue 3</h1>
            <div>
                <input class="inputField" required type="email" placeholder="Your email" v-model="email" />
                <input class="inputField" required type="password" placeholder="Your password" v-model="password" />
            </div>
            <div>
                <input type="submit" class="button block" :value="loading ? 'Loading' : 'Login'" :disabled="loading" />
            </div>
        </div>
    </form>
</template>

<script>
import { ref } from 'vue'
import { supabase } from '../supabase'

const loading = ref(false)
const email = ref('')
const password = ref('')

const handleLogin = async () => {
    try {
        loading.value = true
        const { error } = await supabase.auth.signInWithPassword({
            email: email.value,
            password: password.value,
        })

        if (error) throw error
        alert('You are logged in!')
    } catch (error) {
        if (error instanceof Error) {
            alert(error.message)
        }
    } finally {
        loading.value = false
    }
}

export default {
    name: 'LoginPage',
    setup() {
        return {
            loading,
            email,
            password,
            handleLogin,
        }
    },
}
</script>