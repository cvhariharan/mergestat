import { Alert, Button, Dropdown, Input, Label, Menu, Select, Toolbar } from '@mergestat/blocks'
import { CaretDownIcon, ChevronLeftIcon, ChevronRightIcon, ClipboardIcon, DownloadIcon, SearchIcon } from '@mergestat/icons'
import cx from 'classnames'
import { debounce } from 'lodash'
import Papa from 'papaparse'
import { KeyboardEvent, useEffect, useState } from 'react'
import { QueryResultProps } from 'src/@types'
import { copy, filterByAllFields, getMaxPagination, paginate } from 'src/utils'
import { EXPORT_FORMAT } from 'src/utils/constants'

type TabTableProps = {
  rowLimit: number
  rowLimitReached: boolean
  data: QueryResultProps
  children?: React.ReactNode
}

const TabTable: React.FC<TabTableProps> = ({ rowLimit, rowLimitReached, data }: TabTableProps) => {
  const [result, setResult] = useState<Array<Array<string | number | boolean>>>(data.rows || [])
  const [rows, setRows] = useState<number>(20)
  const [page, setPage] = useState<number>(0)
  const [total, setTotal] = useState<number>(data.rows?.length || 0)
  const [search, setSearch] = useState<string>('')

  const getData = (value: string | number | boolean) => {
    if (value === null) {
      return 'null'
    }
    if (value) {
      if (typeof value === 'boolean') {
        return value.toString()
      } else if (value.constructor === ({}).constructor || value.constructor === ([]).constructor) {
        return JSON.stringify(value)
      }
    }
    return value.toString()
  }

  const isSpecial = (value: string | number | boolean) => {
    return value === null || typeof value === 'boolean'
  }

  const getText = (exportFormat: string) => {
    const allData = [data.columns?.map(c => c.name) || [], ...(data.rows || [])]
    let text
    if (exportFormat === EXPORT_FORMAT.JSON) {
      text = JSON.stringify(allData)
    } else {
      const tratedData = allData.map(data => data.map(d => getData(d)))
      text = Papa.unparse(tratedData)
    }
    return text
  }

  const copyToClipboard = (exportFormat: string) => {
    copy(getText(exportFormat))
  }

  const exportData = (exportFormat: string) => {
    const jsonString = `data:text/${exportFormat.toLowerCase()};charset=utf-8,${encodeURIComponent(getText(exportFormat))}`
    const link = document.createElement('a')
    link.href = jsonString
    link.download = `data.${exportFormat.toLowerCase()}`
    link.click()
  }

  const onChange = debounce((e) => setSearch(e.target.value), 300)

  useEffect(() => {
    let result
    if (search !== '') {
      result = filterByAllFields(data.rows || [], search)
    } else {
      result = data.rows || []
    }

    setResult(result)
    setTotal(result.length)
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [search])

  useEffect(() => {
    const result = filterByAllFields(data.rows || [], search)
    setResult(paginate(result, rows, page))
    setTotal(result.length)
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [rows, page])

  return (
    <>
      {/* Head section */}
      <Toolbar className='bg-white h-16 flex w-full border-b px-5 py-4'>
        <Toolbar.Left>
          <Input
            className='w-96'
            placeholder='Search...'
            startIcon={<SearchIcon className='t-icon' />}
            onChange={onChange}
            onKeyUp={(e: KeyboardEvent<HTMLInputElement>) => (e.key === 'Enter' && setSearch((e.target as HTMLInputElement).value))}
          />
        </Toolbar.Left>
        <Toolbar.Right>
          <Toolbar.Item>
            <Dropdown
              alignEnd
              zIndex={30}
              trigger={
                <Button label='Copy' skin='secondary'
                  startIcon={<ClipboardIcon className='t-icon t-icon-heroicons-clipboard' />}
                  endIcon={<CaretDownIcon className='t-icon' />}
                />
              }
              overlay={(close) => (
                <Menu className='whitespace-nowrap w-full'>
                  <Menu.Item text={EXPORT_FORMAT.JSON} onClick={() => {
                    copyToClipboard(EXPORT_FORMAT.JSON)
                    close()
                  }} />
                  <Menu.Item text={EXPORT_FORMAT.CSV} onClick={() => {
                    copyToClipboard(EXPORT_FORMAT.CSV)
                    close()
                  }} />
                </Menu>
              )}
            />
          </Toolbar.Item>
          <Toolbar.Item>
            <Dropdown
              alignEnd
              zIndex={30}
              trigger={
                <Button label='Download' skin='secondary'
                  startIcon={<DownloadIcon className='t-icon t-icon-heroicons-clipboard' />}
                  endIcon={<CaretDownIcon className='t-icon' />}
                />
              }
              overlay={(close) => (
                <Menu className='whitespace-nowrap w-full'>
                  <Menu.Item text={EXPORT_FORMAT.JSON} onClick={() => {
                    exportData(EXPORT_FORMAT.JSON)
                    close()
                  }} />
                  <Menu.Item text={EXPORT_FORMAT.CSV} onClick={() => {
                    exportData(EXPORT_FORMAT.CSV)
                    close()
                  }} />
                </Menu>
              )}
            />
          </Toolbar.Item>
        </Toolbar.Right>
      </Toolbar>

      {/* Table section */}
      <div className='overflow-hidden flex-1 flex flex-col bg-white h-full w-full'>
        {rowLimitReached && (
          <Alert theme="light" type="warning" className='t-alert-full-width items-center' >
            Query results are limited to {rowLimit} rows.
          </Alert>
        )}
        <div className='overflow-auto w-full flex-1'>
          <table className='t-table-default t-table-sticky-header t-table-nowrap t-table-bordered t-table-dense'>
            <thead>
              <tr className='bg-white'>
                {data.columns && data.columns.length > 0 && data.columns.map((col, index) => (
                  <th key={`th-record-${index}`} scope='col' className='whitespace-nowrap pr-6 pl-8'>
                    <span className='mr-1'>{col.name}</span>
                  </th>
                ))}
              </tr>
            </thead>

            <tbody className='bg-white'>
              {result.map((record, indexRecord) => (
                <tr key={`tr-record-${indexRecord}`}>
                  {record.map((value, index) => (
                    <td key={`td-record-${index}`} className='w-0 pl-8 max-w-xs truncate'>
                      <span className={cx({ 'text-blue-700': isSpecial(value) })}>{getData(value)}</span>
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Footer section */}
      <div className='bg-white overflow-auto flex h-16 flex-shrink-0 w-full border-t px-8'>
        <Toolbar className='t-toolbar flex-1 w-auto h-full space-x-4'>
          <Toolbar.Left className='space-x-3'>
            <div className='flex items-center'>
              <Label className='mr-2 whitespace-nowrap' htmlFor='rowsPerPage'>
                Rows per page
              </Label>
              <Select id='rowsPerPage' className="w-20" defaultValue='20' onChange={e => setRows(+e.target.value)}>
                <option value='10'>10</option>
                <option value='20'>20</option>
                <option value='50'>50</option>
                <option value='100'>100</option>
              </Select>
            </div>
          </Toolbar.Left>
          <Toolbar.Right className='space-x-4 divide-x'>
            <Toolbar.Item className='pl-4'>
              <div className='flex items-center space-x-2'>
                <p className='t-text-muted whitespace-nowrap text-sm'>
                  {`${(page * rows) + 1}-${getMaxPagination(page, rows, total)} of ${total}`}
                </p>
                <Button
                  isIconOnly
                  disabled={page === 0}
                  skin='borderless'
                  startIcon={<ChevronLeftIcon className='t-icon' />}
                  onClick={() => setPage(page - 1)}
                />
                <Button
                  isIconOnly
                  disabled={getMaxPagination(page, rows, total) >= total}
                  skin='borderless'
                  startIcon={<ChevronRightIcon className='t-icon' />}
                  onClick={() => setPage(page + 1)}
                />
              </div>
            </Toolbar.Item>
          </Toolbar.Right>
        </Toolbar>
      </div>
    </>
  )
}

export default TabTable
