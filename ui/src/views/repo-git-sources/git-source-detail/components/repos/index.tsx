import { Panel, Tabs } from '@mergestat/blocks'
import { useGitSourceDetailContext } from 'src/state/contexts/git-source-detail.context'
import ReposAuto from './tabs/repos-auto'
import ReposManual from './tabs/repos-manual'

const ReposAutoManual: React.FC = () => {
  const [{ gsDetail: { auto, totalManual } }] = useGitSourceDetailContext()

  return (
    <Panel className='rounded-md shadow-sm m-auto mt-8'>
      <Panel.Header className='border-b-0 h-14'>
        <div className='w-full flex justify-between'>
          <h4 className='t-h4 mb-0'>Repos</h4>
        </div>
      </Panel.Header>

      <Panel.Body className='p-0'>
        <Tabs>
          <Tabs.List className='border-b px-6'>
            <Tabs.Item>{`Auto (${auto?.length || 0})`}</Tabs.Item>
            <Tabs.Item>{`Manual (${totalManual})`}</Tabs.Item>
          </Tabs.List>
          <Tabs.Panels className="h-full bg-gray-50 overflow-auto">
            <Tabs.Panel>
              <ReposAuto />
            </Tabs.Panel>
            <Tabs.Panel>
              <ReposManual />
            </Tabs.Panel>
          </Tabs.Panels>
        </Tabs>
      </Panel.Body>
    </Panel>
  )
}

export default ReposAutoManual
