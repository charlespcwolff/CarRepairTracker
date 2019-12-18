<template>
   <div>
    <form>
        <button type="submit" class="btn btn-secondary float-center">Complete</button>           
        </form>
    </div>
</template>


<script>
import { APIService } from "@/shared/APIService";
const apiService = new APIService();

export default {
    name: "mark-complete",
    data() {
        return {
            markComplete: false
        }
    },
    props:{
        id : Number
    },
    methods: {
        async markAsComplete() {
            try {
                await apiService.markAsComplete(this.markAsComplete);
                this.markAsComplete = true;
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