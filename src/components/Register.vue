<template>
	<div class="register-container">
		<form class="register-form" @submit.prevent="onRegisterComplete">
			<h1 class="register-header">Erstelle deinen Account</h1>
			<div class="input-group">
				<label for="email">Email</label>
				<input id="email" required type="email" placeholder="Deine Emailadresse" v-model="email" />
			</div>
			<div class="input-group">
				<label for="username">Username</label>
				<input id="username" required type="text" placeholder="Dein Username" v-model="username" />
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

			<div class="input-group">
				<label for="confirmPassword">Passwort bestätigen</label>
				<input
					id="confirmPassword"
					required
					type="password"
					placeholder="Passwort bestätigen"
					v-model="confirmPassword"
				/>
			</div>
			<button type="submit" :class="{ 'button-loading': loading }" :disabled="loading">
				{{ loading ? 'Lädt...' : 'Register' }}
			</button>
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
const username = ref('')
const password = ref('')
const confirmPassword = ref('')
const errorMessage = ref('')

const toast = useToast()

async function onRegisterComplete() {
	try {
		loading.value = true
		errorMessage.value = ''

		if (password.value !== confirmPassword.value) {
			throw new Error('Passwörter stimmen nicht überein')
		}

		const { data, error } = await supabase.auth.signUp({
			email: email.value,
			password: password.value,
			data: { username: username.value },
		})

		if (error) throw new Error(error.message)

		toast.success('Account erfolgreich erstellt. Bitte logge dich ein.')
		await router.push('/login')
	} catch (error) {
		errorMessage.value = error.message
		toast.error(error.message, { timeout: 7000 })
		password.value = ''
		confirmPassword.value = ''
	} finally {
		loading.value = false
	}
}
</script>

<style scoped>
.register-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 75vh; /* Full viewport height */
	overflow: hidden; /* Ensures no scrolling */
}

.register-form {
	padding: 3rem;
	background: white;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2); /* Enhanced shadow for depth */
	border-radius: 10px;
	width: 100%;
	max-width: 350px; /* Controlled max width for alignment */
	display: flex;
	flex-direction: column;
	justify-content: center; /* Ensures the form contents are centered */
}

.register-header {
	margin-bottom: 2.5rem; /* More space under header */
	font-size: 1.8rem; /* Larger font size */
	color: #333;
	font-weight: 600; /* Heavier font weight */
}

.input-group {
	margin-bottom: 1rem; /* More space between inputs */
}

input[type='email'],
input[type='text'],
input[type='password'],
button {
	width: 100%; /* Full width to align with the form */
	padding: 12px 20px; /* Consistent padding */
	margin-top: 8px;
	border-radius: 6px; /* Rounded corners for aesthetics */
	font-size: 1.1rem; /* Consistent font size for readability */
}

input[type='email'],
input[type='text'],
input[type='password'] {
	border: 2px solid #ccc; /* Consistent border thickness */
	background-color: #fafafa; /* Consistent background */
	transition: border-color 0.2s; /* Smooth transition for focus */
	max-width: 87%;
}

input[type='email']:focus,
input[type='text']:focus,
input[type='password']:focus {
	border-color: #405983; /* Highlight color on focus */
}

button {
	background-color: #405983;
	color: white;
	border: none; /* No border for buttons */
	cursor: pointer;
	transition:
		background-color 0.3s,
		transform 0.2s; /* Smooth transitions for interactions */
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
	text-align: center;
}
</style>
