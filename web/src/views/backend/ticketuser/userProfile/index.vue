<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('ticketuser.userProfile.quick Search Fields') })"
        ></TableHeader>

        <!-- 表格 -->
        <!-- 表格列有多种自定义渲染方式，比如自定义组件、具名插槽等，参见文档 -->
        <!-- 要使用 el-table 组件原有的属性，直接加在 Table 标签上即可 -->
        <Table ref="tableRef"></Table>

        <!-- 表单 -->
        <PopupForm />
    </div>
</template>

<script setup lang="ts">
import {
  onMounted,
  provide,
  useTemplateRef,
} from 'vue';

import { baTableApi } from '/@/api/common';
import { defaultOptButtons } from '/@/components/table';
import TableHeader from '/@/components/table/header/index.vue';
import Table from '/@/components/table/index.vue';
import baTableClass from '/@/utils/baTable';
import { useI18n } from 'vue-i18n';

import PopupForm from './popupForm.vue';

defineOptions({
    name: 'ticketuser/userProfile',
})

const { t } = useI18n()
const tableRef = useTemplateRef('tableRef')
const optButtons: OptButton[] = defaultOptButtons(['edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/ticketuser.UserProfile/'),
    {
        pk: 'user_id',
        column: [
            // fixed="right"
            { type: 'selection', align: 'center', operator: false, fixed: 'left' },
            { label: t('ticketuser.userProfile.user_id'), prop: 'user_id', align: 'center', operatorPlaceholder: t('Fuzzy query'), operator: 'LIKE', width: 50, fixed: 'left' },
            {
                label: t('ticketuser.userProfile.real_name'),
                fixed: 'left',
                prop: 'real_name',
                align: 'center',
                showOverflowTooltip: true,
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                sortable: false,
                width: 120
            },
            {
                label: t('ticketuser.userProfile.account_name'),
                prop: 'account_name',
                align: 'center',
                showOverflowTooltip: true,
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                sortable: false,
                width: 120
            },
            {
                label: t('ticketuser.userProfile.wechat_id'),
                prop: 'wechat_id',
                align: 'center',
                showOverflowTooltip: true,
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                width: 120
            },
            {
                label: t('ticketuser.userProfile.bank_card_no'),
                prop: 'bank_card_no',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                sortable: false,
                width: 160
            },
            {
                label: t('ticketuser.userProfile.id_card_no'),
                prop: 'id_card_no',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                sortable: false,
                width: 170
            },
            { label: t('ticketuser.userProfile.id_card1_image'), prop: 'id_card1_image', align: 'center', render: 'image', operator: false, width: 100 },
            { label: t('ticketuser.userProfile.id_card2_image'), prop: 'id_card2_image', align: 'center', render: 'image', operator: false, width: 100 },
            { label: t('ticketuser.userProfile.wechat_qr_image'), prop: 'wechat_qr_image', align: 'center', render: 'image', operator: false, width: 100 },
            { label: t('ticketuser.userProfile.alipay_qr_image'), prop: 'alipay_qr_image', align: 'center', render: 'image', operator: false, width: 120 },
            { label: t('ticketuser.userProfile.created_at'), prop: 'created_at', align: 'center', operator: 'eq', sortable: 'custom', width: 160 },
            { label: t('ticketuser.userProfile.updated_at'), prop: 'updated_at', align: 'center', operator: 'eq', sortable: 'custom', width: 160 },
            { label: t('Operate'), align: 'center', width: 100, render: 'buttons', buttons: optButtons, operator: false, fixed: 'right' },
        ],
        dblClickNotEditColumn: [undefined],
        defaultOrder: { prop: 'real_name', order: 'desc' },
    },
    {
        defaultItems: { created_at: 'CURRENT_TIMESTAMP', updated_at: 'CURRENT_TIMESTAMP' },
    }
)

provide('baTable', baTable)

onMounted(() => {
    baTable.table.ref = tableRef.value
    baTable.mount()
    baTable.getData()?.then(() => {
        baTable.initSort()
        baTable.dragSort()
    })
})
</script>

<style scoped lang="scss"></style>
<style scoped lang="scss"></style>
