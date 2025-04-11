const fs = require('fs');
const { Octokit } = require('@octokit/rest');

async function collectMetrics() {
  const octokit = new Octokit({
    auth: process.env.GITHUB_TOKEN
  });

  const owner = process.env.GITHUB_REPOSITORY.split('/')[0];
  const repo = process.env.GITHUB_REPOSITORY.split('/')[1];

  // Получение метрик сборки
  const workflowRuns = await octokit.actions.listWorkflowRunsForRepo({
    owner,
    repo,
    per_page: 100
  });

  const metrics = {
    timestamp: new Date().toISOString(),
    buildMetrics: {
      totalRuns: workflowRuns.data.total_count,
      successfulRuns: 0,
      failedRuns: 0,
      avgDuration: 0,
      totalDuration: 0
    },
    deploymentMetrics: {
      totalDeployments: 0,
      successfulDeployments: 0,
      failedDeployments: 0,
      avgDeploymentTime: 0
    }
  };

  // Расчет метрик сборки
  let totalDuration = 0;
  let countWithDuration = 0;

  workflowRuns.data.workflow_runs.forEach(run => {
    if (run.name === 'CI') {
      if (run.status === 'completed') {
        if (run.conclusion === 'success') {
          metrics.buildMetrics.successfulRuns++;
        } else {
          metrics.buildMetrics.failedRuns++;
        }

        if (run.updated_at && run.created_at) {
          const duration = new Date(run.updated_at) - new Date(run.created_at);
          totalDuration += duration;
          countWithDuration++;
        }
      }
    } else if (run.name === 'CD') {
      metrics.deploymentMetrics.totalDeployments++;
      if (run.conclusion === 'success') {
        metrics.deploymentMetrics.successfulDeployments++;
      } else {
        metrics.deploymentMetrics.failedDeployments++;
      }
    }
  });

  if (countWithDuration > 0) {
    metrics.buildMetrics.avgDuration = totalDuration / countWithDuration;
    metrics.buildMetrics.totalDuration = totalDuration;
  }

  // Сохранение метрик в файл
  fs.writeFileSync('metrics.json', JSON.stringify(metrics, null, 2));
  console.log('Metrics collected and saved to metrics.json');
}

collectMetrics().catch(error => {
  console.error('Error collecting metrics:', error);
  process.exit(1);
});