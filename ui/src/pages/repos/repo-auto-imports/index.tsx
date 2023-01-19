import type { NextPage } from 'next'
import Head from 'next/head'
import { Fragment } from 'react'
import { MERGESTAT_TITLE } from 'src/utils/constants'

import { RepositoriesProvider } from 'src/state/contexts'
import useCrumbsInit from 'src/views/hooks/useCrumbsInit'
import AutoImports from 'src/views/repo-auto-imports'

const AutoImportPage: NextPage = () => {
  const title = `Repo Auto Imports - Settings  ${MERGESTAT_TITLE}`
  useCrumbsInit()

  return (
    <Fragment>
      <Head>
        <title>{title}</title>
      </Head>
      <RepositoriesProvider>
        <AutoImports />
      </RepositoriesProvider>
    </Fragment>
  )
}

export default AutoImportPage