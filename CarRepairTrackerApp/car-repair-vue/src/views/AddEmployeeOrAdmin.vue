<template>
    <b-container class="register">
        <b-row class="text-center">
        <b-col></b-col> 
          <b-col cols="8" > 
            <h2> Add Employee or Admin </h2>
          <register-info/>
          </b-col>
          <b-col></b-col>
        </b-row>
    </b-container>
</template>

<script>

import RegisterInfo from "@/components/AddEmployeeAdminInfo"
export default {
    name: "AddEmployeeOrAdmin",
    components: {
        AddEmployeeAdminInfo
    }    
};
</script>


<style scoped>

.register img {
  width: 50%;
}

h2{

  padding: 5%
}

@media only screen and (max-width: 500px) {

  h2 {
    font-size: 150%;
  }

  .register {
    font-size: 50%;
    align-content: center;
  }

  .register img {

  width: 100%;
  }
 
}

</style>

