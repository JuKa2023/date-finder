<script>
import DateCard from '@/components/DateCard.vue'

export default {
	name: 'DateList',
	components: {
		DateCard,
	},
	props: {
		date_objects: {
			type: Array,
			required: true,
		},
		isLoading: {
			type: Boolean,
			default: false,
		},
	},
	data() {
		return {
			isLoadingInternal: this.isLoading,
			timer: null,
		}
	},
	watch: {
		isLoading(newValue) {
			if (newValue) {
				this.isLoadingInternal = true
			} else {
				if (this.timer) clearTimeout(this.timer)
				this.timer = setTimeout(() => {
					this.isLoadingInternal = false
				}, 500)
			}
		},
	},
	beforeDestroy() {
		if (this.timer) clearTimeout(this.timer)
	},
}
</script>

<template>
	<div class="results-wrapper">
		<article class="results-container" :class="{ 'is-loading': isLoadingInternal }">
			<DateCard
				v-for="date_object in date_objects"
				:key="date_object.id"
				:date_object="date_object"
			/>
		</article>
		<div :class="['spinner-overlay', { visible: isLoadingInternal }]">
			<div class="spinner"></div>
		</div>
	</div>
</template>

<style scoped>
.results-wrapper {
	position: relative;
	width: 100%;
}

.results-container {
	display: flex;
	flex-direction: row;
	justify-content: center;
	flex-wrap: wrap;
	gap: 20px;
	margin-top: 20px;
	width: 100%;
	transition: filter 1.5s ease-in-out;
}

.results-container.is-loading {
	filter: blur(4px);
}

.spinner-overlay {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: rgba(255, 255, 255, 0.8);
	opacity: 0;
	transition:
		opacity 1.5s ease-in-out,
		visibility 1.5s;
	visibility: hidden;
}

.spinner-overlay.visible {
	opacity: 1;
	visibility: visible;
}

.spinner {
	border: 6px solid rgba(0, 0, 0, 0.1);
	width: 36px;
	height: 36px;
	border-radius: 50%;
	border-left-color: #09f;
	animation: spin 1s ease infinite;
}

@keyframes spin {
	0% {
		transform: rotate(0deg);
	}
	100% {
		transform: rotate(360deg);
	}
}
</style>
