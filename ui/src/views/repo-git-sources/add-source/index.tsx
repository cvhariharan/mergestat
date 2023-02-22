import { useMutation, useQuery } from '@apollo/client'
import { Alert, Button, HelpText, Input, Label, ListItem, Panel, RadioCard, Toolbar } from '@mergestat/blocks'
import { BitbucketIcon, BranchIcon, ChevronRightIcon, GithubIcon, GitlabIcon, RepositoryIcon } from '@mergestat/icons'
import { useRouter } from 'next/router'
import { ChangeEvent, useEffect, useState } from 'react'
import { ADD_GIT_SOURCE } from 'src/api-logic/graphql/mutations/git-sources'
import { GET_GIT_SOURCES } from 'src/api-logic/graphql/queries/get-git-sources'
import Loading from 'src/components/Loading'
import { useGlobalSetState } from 'src/state/contexts'
import { getGitSourceIcon } from 'src/utils'
import { VENDOR_TYPE, VENDOR_URL } from 'src/utils/constants'

const AddSourceView: React.FC = () => {
  const router = useRouter()
  const { setCrumbs } = useGlobalSetState()

  const [name, setName] = useState('')
  const [vendor, setVendor] = useState('')
  const [errorName, setErrorName] = useState<boolean>(false)
  const [errorVendor, setErrorVendor] = useState<boolean>(false)

  const [addGitSource] = useMutation(ADD_GIT_SOURCE, {
    onCompleted: () => {
      console.log('Redirect to git created source')
    }
  })

  const { loading, data } = useQuery(GET_GIT_SOURCES, {
    fetchPolicy: 'no-cache',
  })

  useEffect(() => {
    const crumbs = [
      {
        text: 'Repos',
        startIcon: <RepositoryIcon className='t-icon t-icon-default' />,
        onClick: () => router.push('/repos'),
      },
    ]

    setCrumbs(crumbs)
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  useEffect(() => {
    name && setErrorName(false)
  }, [name])

  useEffect(() => {
    vendor && setErrorVendor(false)
  }, [vendor])

  const handleAddGitSource = () => {
    if (!name) setErrorName(true)
    if (!vendor) setErrorVendor(true)

    if (name && vendor) {
      const vendorUrl = vendor === VENDOR_TYPE.BITBUCKET
        ? VENDOR_URL.BITBUCKET
        : vendor === VENDOR_TYPE.GITHUB
          ? VENDOR_URL.GITHUB
          : vendor === VENDOR_TYPE.GITLAB ? VENDOR_URL.GITLAB : undefined

      addGitSource({
        variables: {
          name,
          vendor,
          settings: {
            url: vendorUrl
          }
        }
      })
    }
  }

  return (
    <div className='flex flex-col flex-1 overflow-hidden'>
      {/* Header */}
      <div className='bg-white h-16 w-full border-b px-8'>
        <Toolbar className='h-full'>
          <Toolbar.Left>
            <h2 className='t-h2 mb-0'>Add Repos</h2>
          </Toolbar.Left>
        </Toolbar>
      </div>

      {/* Content */}
      <div className='p-8 overflow-auto'>
        {/* Panel: Add git surce */}
        <Panel className='rounded-md shadow-sm max-w-4xl m-auto'>
          <Panel.Header>
            <h4 className='t-h4 mb-0 w-full'>Set up</h4>
          </Panel.Header>
          <Panel.Body className='p-6'>
            <div className=''>
              <Label className='text-gray-500' aria-required>Get source name</Label>
              <Input
                value={name}
                variant={errorName ? 'error' : 'default'}
                onChange={(e: ChangeEvent<HTMLInputElement>) => setName(e.target.value)}
              />
              {errorName && (
                <HelpText variant="error">Name is required</HelpText>
              )}
            </div>
            <div className='mt-6'>
              <Label className='text-gray-500' aria-required>Choose provider</Label>
              <div className='flex flex-wrap justify-between'>
                <RadioCard
                  isSelected={vendor === VENDOR_TYPE.GITHUB}
                  label="GitHub"
                  className='my-2 w-64'
                  onChange={() => setVendor(VENDOR_TYPE.GITHUB)}
                  startIcon={<GithubIcon className="t-icon" />}
                />
                <RadioCard
                  isSelected={vendor === VENDOR_TYPE.BITBUCKET}
                  label="Bitbucket"
                  className='my-2 w-64'
                  onChange={() => setVendor(VENDOR_TYPE.BITBUCKET)}
                  startIcon={<BitbucketIcon className="t-icon" />}
                />
                <RadioCard
                  isSelected={vendor === VENDOR_TYPE.GITLAB}
                  label="Gitlab"
                  className='my-2 w-64'
                  onChange={() => setVendor(VENDOR_TYPE.GITLAB)}
                  startIcon={<GitlabIcon className="t-icon" />}
                />
                <RadioCard
                  isSelected={vendor === VENDOR_TYPE.GIT}
                  label="Generic Git"
                  className='my-2 w-64'
                  onChange={() => setVendor(VENDOR_TYPE.GIT)}
                  startIcon={<BranchIcon className="t-icon" />}
                />
              </div>
              {errorVendor && (
                <HelpText variant="error">Provider is required</HelpText>
              )}
            </div>
          </Panel.Body>
          <Panel.Footer>
            <Toolbar className="h-16">
              <Toolbar.Right>
                <Toolbar.Item>
                  <Button skin="primary" onClick={handleAddGitSource} >
                    Continue
                  </Button>
                </Toolbar.Item>
              </Toolbar.Right>
            </Toolbar>
          </Panel.Footer>
        </Panel>

        <div className='max-w-4xl m-auto'>
          <div className='flex justify-center w-full my-6'>
            <div className='h-0 border-gray-200 border-b-2 mt-3 flex-1'></div>
            <span className='px-2'>Or</span>
            <div className='h-0 border-gray-200 border-b-2 mt-3 flex-1'></div>
          </div>
        </div>

        {/* Panel: List git surces */}
        <Panel className='rounded-md shadow-sm max-w-4xl m-auto'>
          <Panel.Header>
            <h4 className='t-h4 mb-0 w-full'>Exisiting git sources</h4>
          </Panel.Header>
          <Panel.Body className='p-6'>
            <Alert type='default' theme='light' className='mb-6'>
              <span>You already have these git sources configured, maybe pick up from one of them instead?</span>
            </Alert>

            <Panel className='rounded-md shadow-sm max-w-4xl m-auto'>
              <Panel.Body className='p-0'>
                {loading
                  ? <Loading />
                  : data?.providers.nodes.map((provider, index) =>
                    <ListItem key={`git-source-${index}`}
                      title={provider.name}
                      className={'px-4 py-2 border-b'}
                      startIcon={getGitSourceIcon(provider.vendor)}
                      onClick={() => console.log(`Go to ${provider.id}`)}
                      action={<div className='t-list-item-go-to'>
                        <span className='px-2'>Go to</span>
                        <ChevronRightIcon className="t-icon" />
                      </div>}
                    />
                  )}
              </Panel.Body>
            </Panel>
          </Panel.Body>
        </Panel>
      </div>
    </div>
  )
}

export default AddSourceView
