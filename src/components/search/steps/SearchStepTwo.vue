<template>
	<div class="content-container">
		<h2>Was ist dein Budget?</h2>
		<p>
			Bitte wähle dein maximales Budget aus, den du für deine Verabredung ausgeben möchtest. Es
			werden dir Vorschläge angezeigt, die deinem Budget entsprechen oder günstiger sind.
		</p>
		<article class="options-container">
			<div
				v-for="option in options"
				:key="option.text"
				@click="selectOption(option)"
				class="cardClickable"
			>
				<div class="top">
					<div>
						<h3 class="activity">{{ option.text }}</h3>
					</div>
					<img class="bildCard" :src="option.img" :alt="`illustration of ${option.text}`" />
				</div>
				<div class="farbbox" :style="{ backgroundColor: option.color }">
					<img class="logo" src="/src/assets/img/logo.svg" alt="logo related to the activity" />
				</div>
			</div>
		</article>
		<button @click="selectOption({ text: 'spielt keine Rolle' })" class="shadow-button">
			egal
		</button>
	</div>
</template>

<script setup>
import { ref, defineEmits } from 'vue'

const kostenlosImgUrl = new URL('/src/assets/img/icons/active.png', import.meta.url).href
const budgetImgUrl = new URL('/src/assets/img/icons/laidback.png', import.meta.url).href
const luxusImgUrl = new URL('/src/assets/img/icons/neutral.png', import.meta.url).href

const options = ref([
	{ text: 'Kostenlos', img: kostenlosImgUrl, color: '#53D1CD' },
	{ text: 'Budget freundlich', img: budgetImgUrl, color: '#C6A9F8' },
	{ text: 'Luxuriös', img: luxusImgUrl, color: '#9DB4A0' },
])

const emits = defineEmits(['step-complete'])

function selectOption(option) {
	if (option.text === 'spielt keine Rolle') {
		for (let i = 0; i < options.value.length; i++) {
			emits('step-complete', options.value[i])
		}
		return
	}
	emits('step-complete', option)
}
</script>

<style scoped></style>
