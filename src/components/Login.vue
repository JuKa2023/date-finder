<template>
	<div class="login-container">
		<form class="login-form" @submit.prevent="handleLogin">
			<h1 class="login-header">Melde dich an</h1>
			<div class="input-group">
				<label for="email">Email</label>
				<input id="email" required type="email" placeholder="Deine Emailaddresse" v-model="email" />
			</div>
			<div class="input-group">
				<label for="password">Passwort</label>
				<input
					id="password"
					required
					type="password"
					placeholder="Dein Passwort"
					v-model="password"
				/>
			</div>
			<button type="submit" :class="{ 'button-loading': loading }" :disabled="loading">
				{{ loading ? 'Lädt...' : 'Login' }}
			</button>
			<p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
		</form>
	</div>
</template>

<script setup>
import { ref } from 'vue'
import { supabase } from '@/supabase'
import { useRouter } from 'vue-router'
import { useToast } from 'vue-toastification'

const router = useRouter()
const loading = ref(false)
const email = ref('')
const password = ref('')

const errorMessage = ref('')

async function handleLogin() {
	loading.value = true
	const { error } = await supabase.auth.signInWithPassword({
		email: email.value,
		password: password.value,
	})

	if (error) {
		// errorMessage.value = error.message
		const toast = useToast()
		toast.error(error.message, {
			timeout: 5000,
		})
	} else {
		errorMessage.value = ''
		await router.push('/dashboard')
	}

	loading.value = false
}
</script>

<style scoped>
.login-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 75vh; /* Full viewport height */
	margin: 0; /* Remove any default margin */
	padding: 0; /* Remove any default padding */
	overflow: hidden; /* Ensures no scrolling */
}

.login-form {
	padding: 3rem;
	background: white;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2); /* Stronger shadow for depth */
	border-radius: 10px;
	width: 100%;
	max-width: 350px; /* Slightly reduced for better focus */
	margin: auto; /* Auto margins for vertical centering */
	display: flex;
	flex-direction: column;
	justify-content: center; /* Ensures the form contents are centered */
}

.login-header {
	margin-bottom: 2.5rem; /* More space under header */
	font-size: 1.8rem; /* Larger font size */
	color: #333;
	font-weight: 600; /* Heavier font weight */
}

.input-group {
	margin-bottom: 1rem; /* More space between inputs */
}

input[type='email'],
input[type='password'] {
	width: 90%;
	padding: 12px; /* Larger padding for better touch */
	margin-top: 8px;
	border: 2px solid #ccc; /* Thicker border */
	border-radius: 6px; /* Slightly rounded */
	background-color: #fafafa; /* Lighter input background */
	transition: border-color 0.2s; /* Smooth transition for border color */
}

input[type='email']:focus,
input[type='password']:focus {
	border-color: #405983; /* Highlight color on focus */
}

button {
	width: 100%;
	padding: 12px 20px; /* Larger padding */
	background-color: #405983;
	color: white;
	font-size: 1.1rem; /* Larger font size */
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition:
		background-color 0.3s,
		transform 0.2s; /* Added transform for hover effect */
}

button:hover {
	background-color: #364b73;
	transform: translateY(-2px); /* Subtle lift effect on hover */
}

.button-loading {
	background-color: #aaa;
}

button:disabled {
	background-color: #ccc;
	cursor: not-allowed;
}

.error-message {
	color: red;
	margin-top: 12px; /* More space above error message */
	font-size: 0.9rem; /* Smaller font size for subtlety */
	text-align: center;
}
</style>
