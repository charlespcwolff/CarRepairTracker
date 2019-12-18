<template>
    <div id="IncidentDetails">
        <incident-details-info :incident="incident" :vehicle="vehicle" :status="status"/>
    </div>
</template>

<script>
import IncidentDetailsInfo from "@/components/IncidentDetailsInfo"

export default {
    name: "incident-details",
    data() {
        return {
            incident: {},
            vehicle: {},
            status: ""
        }
    },
    components: {
        IncidentDetailsInfo
    },
    created() {
        this.incident = this.$route.params.incident.incident;
        this.vehicle = this.$route.params.incident.vehicle;
        this.status = this.$route.params.incident.status;
    }
}
</script>

<style scoped>

</style>