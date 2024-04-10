# Observability Guide

Observability is key for diagnosing and improving application performance. This guide assumes familiarity with DevOps practices and focuses on tooling and metrics for enhanced observability.

## Observability Objectives

- **Visibility:** Access to real-time internal application states.
- **Traceability:** Tracing transactions across components to identify issues.
- **Debuggability:** Quick issue identification and resolution.
- **Performance Monitoring:** Ensuring application meets performance benchmarks.

## Tools and Practices

- **Logging:** Essential for historical analysis and debugging. **Recommendation:** ELK Stack for aggregation and visualization.

- **Monitoring:** Critical for real-time health checks. **Recommendation:** Use Prometheus for metrics collection and Grafana for dashboarding.

- **Traceability:** Key for microservices architecture. **Recommendation:** Zipkin for distributed tracing.

- **Alerting:** Necessary for proactive issue management. **Integration:** Utilize Prometheus and Grafana's alerting capabilities.

## Key Performance Indicators

- **Latency:** Time for request processing.
- **Throughput:** Request processing capacity.
- **Error Rate:** Percentage of failed requests.
- **Resource Utilization:** CPU, memory, and disk metrics.
- **User Satisfaction:** Apdex score for user experience.

Leveraging ELK Stack, Prometheus, Grafana, and Zipkin enables comprehensive observability, essential for maintaining and optimizing application performance.

## Distributed Tracing with Zipkin

Distributed tracing, particularly with Zipkin, offers detailed insights into request flows across microservices, aiding in pinpointing latency and failures.

### Integration Steps

- **Instrumentation:** Add tracing data collection to application services, either manually or via OpenTelemetry-compatible libraries.
- **Propagation:** Ensure trace IDs are forwarded across service calls.
- **Collection & Storage:** Aggregate tracing data in Zipkin for analysis.
- **Analysis & Visualization:** Use Zipkin UI for trace data insights, focusing on request paths and operation durations.

### Proposed stack

A good obserbavility stack should incorporate the following components:

- **Zipkin**
- **ELK**
- **Prometheus**
- **Graphana**

Seeing as this would be implemented on AWS, going into more specifics probably using native AWS tools would provide less friction. So here is a sugestion for replacing the previous stack with AWS Services:

- **Amazon ES**: Provides funtionality equivalent to Elasticsearch and Kibana
- **Amazon Kinesis Data Firehose**: this would replace the logstash functionality
- **Cloudwatch**: provides similarl functionality to Prometheus and Graphana combined
  #### alternatively:
  - **Amazon Managed Prometheus**
  - **Amazon Managed Graphana**
- **AWS X-Ray**: Equivalent to Zipkin
