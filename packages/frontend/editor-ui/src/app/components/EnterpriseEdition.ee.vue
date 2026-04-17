<script setup lang="ts">
import { computed } from 'vue';
import type { EnterpriseEditionFeatureValue } from '@/Interface';
import { useSettingsStore } from '@/app/stores/settings.store';

// Enable the dev bypass when the Vite env flag is set or when running in development mode.
// This ensures the unconditional show of EE features is only active for local/dev runs.
const DEV_LICENSE_BYPASS =
	import.meta.env.VITE_DEV_LICENSE_BYPASS === 'true' || import.meta.env.MODE === 'development';

const props = withDefaults(
	defineProps<{
		features: EnterpriseEditionFeatureValue[];
	}>(),
	{
		features: () => [],
	},
);

const settingsStore = useSettingsStore();

const canAccess = computed(() =>
	props.features.reduce(
		(acc: boolean, feature) => acc && !!settingsStore.isEnterpriseFeatureEnabled[feature],
		true,
	),
);
</script>

<template>
	<div>
		<slot v-if="DEV_LICENSE_BYPASS || canAccess" />
		<slot v-else name="fallback" />
	</div>
</template>
