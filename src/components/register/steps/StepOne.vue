<template>
	<div>
		<h2>Gebe deinen Vornamen und deine Email ein</h2>
		<form class="login" @submit.prevent="nextStep">
			<div class="imputRegister">
				<label for="firstName">Vorname</label>
				<input
					type="text"
					id="firstName"
					placeholder="Vorname"
					v-model="personalInfo.firstName"
					required
				/>
			</div>

			<div class="imputRegister">
				<label for="email">Email</label>
				<input type="email" id="email" placeholder="Email" v-model="personalInfo.email" required />
			</div>
			<h3>Wähle einen passenden Username</h3>

			<div class="imputRegister">
				<label for="username">Username</label>
				<input
					type="text"
					id="username"
					placeholder="Username"
					v-model="personalInfo.username"
					required
				/>
			</div>

			<button type="submit">Weiter</button>
		</form>
	</div>
</template>

<script>
export default {
	data() {
		return {
			personalInfo: {
				firstName: '',
				email: '',
				username: '',
			},
		}
	},
	methods: {
		nextStep() {
			this.$emit('next', this.personalInfo)
		},
	},
}
</script>

<style scoped>
.login {
	display: flex;
	flex-direction: column;
	gap: 1rem;
	width: 100%;
	margin: 0 auto;
}

.imputRegister {
	display: flex;
	flex-direction: row;
	gap: 1rem;
}
</style>
