<template>
    <div class="default-main ba-table-box">
        <el-alert class="ba-table-alert" v-if="baTable.table.remark" :title="baTable.table.remark" type="info" show-icon />

        <!-- 表格顶部菜单 -->
        <!-- 自定义按钮请使用插槽，甚至公共搜索也可以使用具名插槽渲染，参见文档 -->
        <TableHeader
            :buttons="['refresh', 'add', 'edit', 'delete', 'comSearch', 'quickSearch', 'columnDisplay']"
            :quick-search-placeholder="t('Quick search placeholder', { fields: t('ticketuser.ticketUser.quick Search Fields') })"
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
import { onMounted, provide, useTemplateRef } from 'vue'
import { useI18n } from 'vue-i18n'
import PopupForm from './popupForm.vue'
import { baTableApi } from '/@/api/common'
import { defaultOptButtons } from '/@/components/table'
import TableHeader from '/@/components/table/header/index.vue'
import Table from '/@/components/table/index.vue'
import baTableClass from '/@/utils/baTable'

defineOptions({
    name: 'ticketuser/ticketUser',
})

const { t } = useI18n()
const tableRef = useTemplateRef('tableRef')
const optButtons: OptButton[] = defaultOptButtons(['edit', 'delete'])

/**
 * baTable 内包含了表格的所有数据且数据具备响应性，然后通过 provide 注入给了后代组件
 */
const baTable = new baTableClass(
    new baTableApi('/admin/ticketuser.TicketUser/'),
    {
        pk: 'id',
        column: [
            { type: 'selection', align: 'center', operator: false },
            { label: t('ticketuser.ticketUser.id'), prop: 'id', align: 'center', width: 70, operator: 'RANGE', sortable: 'custom' },
            {
                label: t('ticketuser.ticketUser.phone'),
                prop: 'phone',
                align: 'center',
                operatorPlaceholder: t('Fuzzy query'),
                operator: 'LIKE',
                sortable: false,
            },
            { label: t('ticketuser.ticketUser.avatar'), prop: 'avatar', align: 'center', render: 'image', operator: false },
            {
                label: t('ticketuser.ticketUser.gender'),
                prop: 'gender',
                align: 'center',
                operator: 'RANGE',
                sortable: false,
                replaceValue: {
                    '0': t('ticketuser.ticketUser.gender 0'),
                    ' 1': t('ticketuser.ticketUser.gender  1'),
                    ' 2': t('ticketuser.ticketUser.gender  2'),
                },
            },
            {
                label: t('ticketuser.ticketUser.status'),
                prop: 'status',
                align: 'center',
                operator: 'RANGE',
                sortable: false,
                replaceValue: {
                    '0': t('ticketuser.ticketUser.status 0'),
                    ' 1': t('ticketuser.ticketUser.status  1'),
                    ' 2': t('ticketuser.ticketUser.status  2'),
                },
            },
            // {
            //     label: t('ticketuser.ticketUser.role'),
            //     prop: 'role',
            //     align: 'center',
            //     operator: 'RANGE',
            //     sortable: false,
            //     replaceValue: {
            //         '0': t('ticketuser.ticketUser.role 0'),
            //         ' 1': t('ticketuser.ticketUser.role  1'),
            //         ' 2': t('ticketuser.ticketUser.role  2'),
            //         ' 9': t('ticketuser.ticketUser.role  9'),
            //     },
            // },
            { label: t('ticketuser.ticketUser.email'), prop: 'email', align: 'center', operator: 'eq', sortable: 'custom', width: 160 },
            { label: t('ticketuser.ticketUser.created_at'), prop: 'created_at', align: 'center', operator: 'eq', sortable: 'custom', width: 160 },
            { label: t('ticketuser.ticketUser.updated_at'), prop: 'updated_at', align: 'center', operator: 'eq', sortable: 'custom', width: 160 },
            // { label: t('ticketuser.ticketUser.deleted_at'), prop: 'deleted_at', align: 'center', operator: 'eq', sortable: 'custom', width: 160 },
            { label: t('Operate'), align: 'center', width: 100, render: 'buttons', buttons: optButtons, operator: false },
        ],
        dblClickNotEditColumn: [undefined],
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
