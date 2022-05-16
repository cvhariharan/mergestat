
import { Button, Checkbox, HelpText, Panel, Table, Toolbar } from '@mergestat/blocks'
import { CaretDownIcon, PencilIcon, RefreshIcon } from '@mergestat/icons'
import React from 'react'
import { SyncDataDropDown } from '../../drop-downs/sync-repos-data-drop-down'
import { columns } from './columns'
import { sampleRepositoriesData } from './sample-data'

export const RepositoriesTable: React.FC = (props) => {
  const {
    repositories,
    selectedRepositoriesCount,
    onCheckBoxClicked,
    selectAllRepositories
  } = useReposStateHandler()
  const allSelected = selectedRepositoriesCount === repositories.length
  // TODO: export this logic to a hook
  const processedData = repositories.map((item, index) => ({
    checkbox: { selected: item.selected, onChange: () => onCheckBoxClicked(item.repositoryName) },
    repository: {
      name: item.repositoryName,
      icons: item.icons,
      lastUpdate: item.lastUpdate,
    },
    tags: item.tags,
    last: item.lastSync,
    status: item.status,
    option: "",
  }))

  return (
    <Panel className="rounded-md h-full w-full">
      <Panel.Header className='px-0'>
        <Toolbar>
          <Toolbar.Left>
            <div className='flex items-center gap-6'>
              <Checkbox
                checked={allSelected}
                onChange={(e) => {
                  const checked = e.currentTarget.checked
                  selectAllRepositories(checked)
                }}
              />
              <HelpText>
                <span className='text-samantic-header'>
                  {allSelected && `All ${selectedRepositoriesCount} `}
                  {!allSelected && `${selectedRepositoriesCount} of ${repositories.length} `}
                </span>
                repos selected
              </HelpText>
            </div>
          </Toolbar.Left>
          <Toolbar.Right>
            <div className='flex items-center gap-2'>
              <SyncDataDropDown
                triger={
                  <Button
                    className='flex items-center gap-2'
                    endIcon={<CaretDownIcon className='w-4.5 h-4.5 text-samantic-icon' />}
                    startIcon={<RefreshIcon className='w-4.5 h-4.5 text-samantic-icon' />}
                    skin='secondary'
                    size="small"
                  >
                    Sync Data
                  </Button>
                }
              />

              <Button
                className='flex items-center gap-2'
                endIcon={<CaretDownIcon className='w-4.5 h-4.5 text-samantic-icon' />}
                startIcon={<PencilIcon className='w-4.5 h-4.5 text-samantic-icon' />}
                skin='secondary'
                size="small"
              >
                Edit Tags
              </Button>
            </div>
          </Toolbar.Right>
        </Toolbar>
      </Panel.Header>
      <Panel.Body className='p-0'>
        <Table
          noWrapHeaders
          className="relative z-0 border-b bg-gray-50"
          tableWrapperClassName='h-full'
          columns={columns}
          dataSource={processedData}
          responsive
          borderless
          scrollY="100%"
        />
      </Panel.Body>
    </Panel>
  )
}

const useReposStateHandler = () => {
  const [repositories, setRepositories] = React.useState(
    sampleRepositoriesData.map(repo => ({ ...repo, selected: false }))
  )


  const onCheckBoxClicked = (repository: string) => {
    setRepositories((prev) =>
      prev.map((item) => ({
        ...item,
        selected: item.repositoryName === repository ? !item.selected : item.selected,
      }))
    )
  }

  const selectAllRepositories = (checked: boolean) => {
    setRepositories((prev) =>
      prev.map((item) => ({ ...item, selected: checked }))
    )
  }

  return {
    repositories,
    selectedRepositoriesCount: repositories.filter((repo) => repo.selected).length,
    onCheckBoxClicked,
    selectAllRepositories,
  }
}