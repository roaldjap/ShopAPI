<script>
import { Bar, mixins } from "vue-chartjs";
const { reactiveProp } = mixins;

export default {
  extends: Bar,
  mixins: [reactiveProp],
  props: {
    chartData: {
      type: Object,
      default: null,
    },
    options: {
      type: Object,
      default: null,
    },
    apn_value: null,
  },
  mounted() {
    this.renderChart(this.chartData, this.options);
  },

  watch: {
    chartData() {
      if (this.apn_value === null) {
        this.$data._chart.destroy();
        return false
      }
      this.renderChart(this.chartData, this.options);
    },
  },
};
</script>
