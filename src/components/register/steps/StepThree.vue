<template>
	<div>
		<h2>Step 3: Einschränkungen angeben</h2>
		<form @submit.prevent="$emit('next', limitations)">
			<textarea placeholder="Deine Einschränkungen" v-model="limitations" required></textarea>
			<button type="submit">Weiter</button>
		</form>
	</div>
</template>

<script>
export default {
	data() {
		return {
			limitations: '',
		}
	},
}
</script>
