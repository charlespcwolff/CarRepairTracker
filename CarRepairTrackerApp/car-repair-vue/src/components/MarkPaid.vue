<template>
   <div>
    <form>
        <button v-on:click="ItemFormShow = !ItemFormShow" type="submit" class="btn btn-danger float-center">Paid In Full</button>            
        </form>
    </div>
</template>


<script>
import { APIService } from "@/shared/APIService";
const apiService = new APIService();

export default {
    name: "mark-paid",
    data() {
        return {
            markPaid: false,
            ItemFormShow: false
        }
    },
    props:{
        id : Number
    },
    methods: {
        async markAsPaid() {
            try {
                await apiService.markAsPaid(this.markPaid);
                this.markPaid = true;
                this.$emit('reload', "");
            } catch (error) {
                this.error = error.message;
            }
        } 
    },
}
</script>

<style scoped>

.form-group {
  justify-content: center;  
  align-content: center;
}
.btn {

    font-size: 100%;
  }
</style>