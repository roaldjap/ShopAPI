<script>
import { Line, mixins } from "vue-chartjs";
const { reactiveProp } = mixins;

export default {
  extends: Line,
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
      this.renderChart(this.chartData, this.options);
    },
  },
};
</script>
