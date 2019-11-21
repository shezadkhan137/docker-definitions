FROM ubuntu:18.04

WORKDIR /opt

COPY install_openvino.sh /opt/install_openvino.sh
RUN ./install_openvino.sh && rm install_openvino.sh

ENV PYTHONPATH=/opt/intel/openvino_2019.3.334/python/python3.6:/opt/intel/openvino_2019.3.334/python/python3
ENV LD_LIBRARY_PATH=/opt/intel/openvino_2019.3.334/opencv/lib:/opt/intel/opencl:/opt/intel/openvino_2019.3.334/deployment_tools/inference_engine/external/hddl/lib:/opt/intel/openvino_2019.3.334/deployment_tools/inference_engine/external/gna/lib:/opt/intel/openvino_2019.3.334/deployment_tools/inference_engine/external/mkltiny_lnx/lib:/opt/intel/openvino_2019.3.334/deployment_tools/inference_engine/external/tbb/lib:/opt/intel/openvino_2019.3.334/deployment_tools/inference_engine/lib/intel64:/opt/intel/openvino_2019.3.334/openvx/lib

ENTRYPOINT [ "bash" ]
