<template>
    <div>
      <!-- Dynamically renders the current step component -->
      <component :is="steps[currentStep].component" @step-complete="nextStep"/>
    </div>
</template>
  
<script>
  export default {
    data() {
      return {
        currentStep: 0,
        steps: [
          { component: 'StepOne' },
          { component: 'StepTwo' }
        ]
      };
    },
    methods: {
      nextStep() {
        if (this.currentStep < this.steps.length - 1) {
          this.currentStep++;
        }
      }
    }
  }
</script>
  