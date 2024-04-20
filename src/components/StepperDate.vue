<template>
    <div class="format">
      <div class="progress-bar-container">
        <div class="progress-bar" :style="{ width: progressBarWidth }"></div>
      </div>
      <component :is="steps[currentStep].component" @step-complete="nextStep"/>
    </div>
</template>
  
  <script>
  import StepOne from './StepOne.vue';
  import StepTwo from './StepTwo.vue';
  import StepThree from './StepThree.vue';
  import StepFour from './StepFour.vue';
  import StepFive from './StepFive.vue';

  export default {
    components: {
      StepOne,
      StepTwo,
      StepThree,
      StepFour,
      StepFive,
    },
    data() {
      return {
        currentStep: 0,
        steps: [
          { component: 'StepOne' },
          { component: 'StepTwo' },
          { component: 'StepThree'},
          { component: 'StepFour'},
          { component: 'StepFive'},
        ]
      };
    },
    computed: {
      progressBarWidth() {
        return ((this.currentStep + 1) / this.steps.length * 100) + '%';
      }
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
  
  <style scoped>
  .progress-bar-container {
    width: 100%;
    height: 20px;
    background-color: #ffffff;
    border-radius: 10px;
    margin-bottom: 10px;
  }
  .progress-bar {
    height: 100%;
    background-color: #405983;
    border-radius: 10px;
    transition: width 0.3s ease-in-out;
  }
  </style>
  